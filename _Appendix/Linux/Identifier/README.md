# Identifiers in Linux
Mainly three identifiers are available in Linux.

1. Process ID
2. User ID
3. Group ID

## # Process ID
**Process ID(PID)** is a number that allows a user to identify a process to other applications. It is assigned to each process when it is created. The first process that Linux runs is `systemd` whose PID is `0`. All other processes are spawn as children of it.

In Linux, there are `.pid` files which are used to store PID of running processes. They are usually in the */var/run*.

## # User ID and Group ID
**User ID(UID)** is a classification of users, and **group ID(GID)** is of groups in the kernel level of the Linux OS.
Both of them are translated to specific unsigned integer values,
which type is faster and smaller than string so that being preferred when passing the data.

There are three kinds of user ID and group ID defined for a process in Linux OS.

* Real User ID / Real Group ID
* Effective User ID / Effective Group ID
* Saved User ID / Saved Group ID

I'll explain these based on the "user ID".

### 1. Real User ID
**Real User ID(RUID)** is an ID of the user who has started the process.

We can know it by using a command, `logname`.

    $ logname

### 2. Effective User ID
**Effective User ID(EUID)** is an ID which is normally the same as *Real User ID*, but can be changed to give files accessing privilege to a non-privileged user.

We can know it by using a command, `whoami`.

    $ whoami

### Usage
It is used to give a user to temporarily take another user's identity, usually elevating one's privilege. Mostly *root*'s identity is taken. The EUID management must restrict users' behavior with delicacy.

When you are going to allow a non-privileged user to access a file for a moment, you might consider giving him the *write* privilege using `chmod`. However, not only the privilege switching is inconvenient, it causes security risk since the user can move, modify, or even delete the file at will!

Instead of doing that, it is better to use the effecitve UID. It gives him the privilege temporarily, disabling him doing any unauthorized actions without being granted authorized user's identity.

#### Examples

##### * EUID in [`passwd`](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/Commands/P/passwd)

With the command `passwd`, a user can change her own user password, but not other ones. It would be very dangerous if one can modify other users' password without any permissions.
How can it work like that? 

According to the source code [`passwd.c`](https://github.com/shadow-maint/shadow/blob/f76c31f50ed0cca018591cc2d0b43837d6224f7d/src/passwd.c#L990C2-L1004C1), a user can change a password when one of these two conditions are met.

1. The user is root.
2. The UID of a user (target to change the password) is the same as the current real UID.

And we should check two files for understanding the command.

1. `passwd` is the same as `/usr/bin/passwd`.
2. A shadow password file, `/etc/shadow`, stores encrypted user passwords.

Note that `/etc/passwd` is completely different file so has no relation to the command! Now let's examine the file permissions of those two files!

![passwd](https://github.com/reruo321/OS-Self-Study/assets/48712088/722d5a54-1537-4c6f-9494-ad03ea8149a7)

![shadow](https://github.com/reruo321/OS-Self-Study/assets/48712088/598f451a-c9a0-4b55-be3e-2b0227de0868)

The permissions of `passwd` is `-rwsr-xr-x`, and the user owner is *root*. Since the file execute permission for the user owner is "s", it has the `setuid` bit set. If a non-*root* user tries to execute this command, she gets the EUID of *root*.

The permissions of the shadow file is `-rw-r-----`, and the user owner is *root*. It means that no one other than *root* is allowed to write this file. After the non-*root* user gets the *root*'s identity through the `passwd`, she can modify her password by writing `/etc/shadow`.

In other words, she can change her own password even if she is not actually *root*, by temporarily getting the *root*'s privilege via the `passwd` and changing the shadow password file.

Then why she cannot change other users' password? See the Condition 2 above; it's because the UID (=any other user's UID) and the current real UID (=the UID of the user who are using the command) are different! Since 1) the current real UID remains as her UID and 2) every UID is unique, it is never the same as the UIDs of other users. Thus, no one except *root* can change other user's password. You must switch to *root* with `su` to do that.

### 3. Saved User ID
**Saved User ID(SUID)** is an ID used to lower a process with an elevated privilege temporarily, usually *root*. When a process needs an under-privilege, it saves its current EUID as SUID, and then changes its EUID as an unprivileged one. Later, it brings its SUID back to the EUID to resume its elevated privilege.

Without the SUID, a process cannot know the UID of another process, since there is no standard and reliable system call to explicitly get it. Moreover, it also prevents a user from messing things up in the system. Imagine a novice who spams her privilege with setuid-root programs and ruins all the whole system! Users should have lower privileges as much as possible for safety, and the SUID does good work here.

### Functions
Various functions to set the process UIDs are provided by the Standard C library and Linux. They may have UID, EUID, RUID, or which as their parameters.

Note: I'll specify process's UIDs from parameters with an underline, like: <ins>UID</ins>.

#### Header
    #include <unistd.h>

#### Possible Errors
> Error: EPERM: operation not permitted
* **EPERM**: The process does not have the appropriate privileges, the UID and EUID paramters are NOT equal to either the RUID or SUID of the process.

> Error: EINVAL: invalid argument
* **EINVAL**: The value of the UID or EUID parameter is not valid.

#### `setuid`
    int setuid(UID)
    uid_t UID;

`setuid` sets the process's <ins>RUID</ins>, <ins>EUID</ins>, and <ins>SUID</ins> to the value of the UID parameter.

* If the EUID of the process is *root*: `setuid` sets <ins>RUID</ins>=UID, <ins>EUID</ins>=UID, <ins>SUID</ins>=UID.
* If the <ins>EUID</ins> of the process is NOT *root* AND if the UID parameter is equal to <ins>RUID</ins> or <ins>SUID</ins>: `setuid` sets <ins>EUID</ins>=UID. Does not change <ins>RUID</ins> and <ins>SUID</ins>.

#### `seteuid`
    int seteuid(EUID)
    uid_t EUID;

`seteuid` sets the <ins>EUID</ins> to the value of the UID parameter.

* If the <ins>EUID</ins> of the process is *root*: `seteuid` sets <ins>EUID</ins>=UID.
* If the UID parameter is equal to either the current <ins>RUID</ins> or <ins>SUID</ins>: `seteuid` sets </ins>EUID</ins>=UID.

#### `setruid`
    int setruid(RUID)
    uid_t RUID;
    
`setruid` sets the <ins>RUID</ins> to the value of the UID parameter.

* Since processes cannot reset only their <ins>RUID</ins>s, the EPERM error code is always returned.

#### `setreuid`
    int setreuid(RUID, EUID)
    uid_t RUID;
    uid_t EUID;

`setreuid` sets the <ins>RUID</ins> to the value of the RUID parameter, and the <ins>EUID</ins> to the value of the *EUID* parameter.

* If two parameters RUID!=EUID AND if EUID paramter is equal to the process's <ins>RUID</ins> or <ins>SUID</ins>: <ins>EUID</ins>=EUID
* If two parameters RUID!=EUID AND if EUID paramter is NOT equal to the process's <ins>RUID</ins> or <ins>SUID</ins>: EPERM error
* If two parameters RUID==EUID AND if the process <ins>EUID</ins> is *root*: <ins>RUID</ins>=EUID, <ins>EUID</ins>=EUID
* If two parameters RUID==EUID AND if the process <ins>EUID</ins> is NOT *root*: EPERM error

## Read Together
* [`passwd`](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/Commands/P/passwd)

### External Links
* [What Are Unix PIDs and How Do They Work?](https://www.howtogeek.com/devops/what-are-unix-pids-and-how-do-they-work/)
* [setuid, setruid, seteuid, setreuid or setuidx Subroutine](https://www.ibm.com/docs/en/aix/7.3?topic=s-setuid-setruid-seteuid-setreuid-setuidx-subroutine)
