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
Various functions to set the process UIDs are provided by the Standard C Library and Linux. They may have UID, EUID, or RUID as their parameters.

Note: I'll specify process's UIDs from parameters with an underline, like: <ins>UID</ins>.

#### Header
    #include <unistd.h>

#### Possible Errors
> Error: EPERM: operation not permitted
* **EPERM**: The process does not have the appropriate privileges, the UID and EUID paramters are NOT equal to either the RUID or SUID of the process.

> Error: EINVAL: invalid argument
* **EINVAL**: The value of the UID or EUID parameter is not valid.

#### `setuid`
    #include <unistd.h>
    
    int setuid(uid_t uid);

* [`setuid` - Linux manual page](https://man7.org/linux/man-pages/man2/setuid.2.html)

`setuid` sets the process's <ins>EUID</ins>, and also conditionally <ins>RUID</ins> and <ins>SUID</ins> to the value of the UID parameter.

* If the calling process is privileged (if the user is *root* OR the program is set-user-ID-*root*): If the EUID of the caller is superuser, `setuid` sets <ins>RUID</ins>=UID, <ins>EUID</ins>=UID, <ins>SUID</ins>=UID.
* Otherwise: `setuid` sets <ins>EUID</ins>=UID. Does not change <ins>RUID</ins> and <ins>SUID</ins>.

#### `setgid`
    #include <unistd.h>
    
    int setgid(gid_t gid);

* [`setgid` - Linux manual page](https://man7.org/linux/man-pages/man2/setgid.2.html)

`setgid` sets the process's <ins>EGID</ins>, and also conditionally <ins>RGID</ins> and <ins>SGID</ins> to the value of the GID parameter.

* If the calling process is privileged with having CAP_SETGID capability in its user namespace: `setgid` sets <ins>RGID</ins>=GID, <ins>EGID</ins>=GID, <ins>SGID</ins>=GID.

#### `setreuid` / `setregid`
       #include <unistd.h>

       int setreuid(uid_t ruid, uid_t euid);
       int setregid(gid_t rgid, gid_t egid);

* [`setreuid` - Linux manual page](https://man7.org/linux/man-pages/man2/setreuid.2.html)

`setreuid` sets the <ins>RUID</ins> to the value of the RUID parameter, and the <ins>EUID</ins> to the value of the *EUID* parameter.

* If the RUID is -1: Do not change <ins>RUID</ins>.
* If the EUID is -1: Do not change <ins>EUID</ins>.
* If a process is unprivileged AND the EUID is equal to <ins>RUID</ins>, <ins>EUID</ins>, or <ins>SUID</ins>: sets <ins>EUID</ins>=RUID or <ins>EUID</ins>=EUID or <ins>EUID</ins>=SUID.
* If a user is unprivileged: sets <ins>RUID</ins>=RUID or <ins>RUID</ins>=EUID.
* If the RUID is not -1 OR the EUID is not equal to the previous RUID: <ins>SUID</ins>=EUID.
* If a process is privileged: sets <ins>RUID</ins>=RUID, <ins>EUID</ins>=EUID.

#### `setresuid` / `setresgid`
       #define _GNU_SOURCE
       #include <unistd.h>

       int setresuid(uid_t ruid, uid_t euid, uid_t suid);
       int setresgid(gid_t rgid, gid_t egid, gid_t sgid);

* [`setresuid` - Linux manual page](https://man7.org/linux/man-pages/man2/setresuid.2.html)

`setresuid` sets the <ins>RUID</ins>, the <ins>EUID</ins>, and the <ins>SUID</ins> of the calling process.

* If a process is unprivileged: change its <ins>RUID</ins>, <ins>EUID</ins>, <ins>SUID</ins>, each to one of the current RUID, EUID, or SUID.
* If a process is privileged with having CAP_SETUID capability: sets <ins>RUID</ins>, <ins>EUID</ins>, <ins>SUID</ins> to arbitrary values.
* If one of the arguments equals -1: the corresponding <ins>ID</ins> is not changed.
* The filesystem UID: is always set to the same value as the (possibly new) EUID.

## Read Together
* [`passwd`](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/Commands/P/passwd)

### External Links
* [What Are Unix PIDs and How Do They Work?](https://www.howtogeek.com/devops/what-are-unix-pids-and-how-do-they-work/)
* [`setuid` - Linux manual page](https://man7.org/linux/man-pages/man2/setuid.2.html)
* [`setreuid` - Linux manual page](https://man7.org/linux/man-pages/man2/setreuid.2.html)
* [`setresuid` - Linux manual page](https://man7.org/linux/man-pages/man2/setresuid.2.html)
