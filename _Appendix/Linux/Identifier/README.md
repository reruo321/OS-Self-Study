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

With `passwd`, a user can change her own user password, but not others.
Why?
Let's examine the file permissions of `passwd`.

![passwd](https://github.com/reruo321/OS-Self-Study/assets/48712088/722d5a54-1537-4c6f-9494-ad03ea8149a7)

It is `-rwsr-xr-x`. Since the file execute permission for the user owner is "s", it has the `setuid` bit set. If a user who is not *root* tries to use this command, she gets EUID as *root*.
Therefore, she can change her own password by temporarily getting the *root*'s privilege.

Then why she cannot change other users' password?


### 3. Saved User ID
**Saved User ID** 

## Group ID

## Read Together
* (External Link) [What Are Unix PIDs and How Do They Work?](https://www.howtogeek.com/devops/what-are-unix-pids-and-how-do-they-work/)
