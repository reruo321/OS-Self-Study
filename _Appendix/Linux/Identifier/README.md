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

I'll explain these based on the user ID.

### 1. Real User ID
**Real User ID** is an ID of the user who has started the process.

We can know it by using a command, `logname`.

    $ logname

### 2. Effective User ID
**Effective User ID(EUID)** is an ID which is normally the same as *Real User ID*, but can be changed to give files accessing privilege to a non-privileged user.

We can know it by using a command, `whoami`.

    $ whoami

### Usage
It is used to give a user to temporarily take another user's identity, which is mostly the *root*'s identity. It must be used to restrict users' behavior with delicacy.

When you are going to allow a non-privileged user to access a file for a moment, you might consider giving him the *write* privilege using `chmod`. However, not only the privilege switching is inconvenient, it causes security risk since the user can move, modify, or even delete the file at will!

Instead of doing that, it is better to use the effecitve UID. It gives him the privilege temporarily, disabling him doing any unauthorized actions without being granted authorized user's identity.

#### Examples

##### * EUID in [`passwd`](https://github.com/reruo321/OS-Self-Study/blob/main/_Appendix/Linux/Commands/P/passwd/README.md)

With the command `passwd`, a user can change her own user password, but not others. It would be very dangerous if one can modify other users' password without any permissions.
How can it work like that?

Note that we should know two files for understanding it: `passwd` is the command known as `/usr/bin/passwd`, and `/etc/shadow` is a shadow password file which stores encrypted user passwords. Let's examine the file permissions of them!

![passwd](https://github.com/reruo321/OS-Self-Study/assets/48712088/722d5a54-1537-4c6f-9494-ad03ea8149a7)

![shadow](https://github.com/reruo321/OS-Self-Study/assets/48712088/598f451a-c9a0-4b55-be3e-2b0227de0868)

The permissions of `passwd` is `-rwsr-xr-x`, and the user owner is *root*. Since the file execute permission for the user owner is "s", it has the `setuid` bit set. If a non-*root* user tries to execute this command, she gets the EUID of *root*.

The permissions of the shadow file is `-rw-r-----`, and the user owner is *root*. It means that no one other than *root* is allowed to write this file. After the non-*root* user gets the *root*'s identity through the `passwd`, she can write `/etc/shadow`.

In other words, she can change her own password even if she is not actually *root*, by temporarily getting the *root*'s privilege via the `passwd` and changing the shadow password file.

Then why she cannot change other users' password? It's because the real UID and the effective UID of the process are different!


### 3. Saved User ID
**Saved User ID** 

## Group ID

## Read Together
* (External Link) [What Are Unix PIDs and How Do They Work?](https://www.howtogeek.com/devops/what-are-unix-pids-and-how-do-they-work/)
