# Identifiers in Linux
Mainly three identifiers are available in Linux.

1. Process ID
2. User ID
3. Group ID

**Process ID(PID)** is a number that allows a user to identify a process to other applications. The first process that Linux runs is `systemd` whose PID is `0`. All other processes are spawn as children of it.

**User ID(UID)** is a classification of users, and **group ID(GID)** is of groups in the kernel level of the Linux OS.
Both of them are translated to specific unsigned integer values,
which type is faster and smaller than string so that being preferred when passing the data.

## Process ID

## User ID
There are three kinds of user ID defined for a process in Linux OS.

* Real User ID
* Effective User ID
* Saved User ID

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

Instead of doing that, it is better to use the effecitve UID. It gives him the privilege temporarily, disabling him doing any unauthorized actions without being granted another one's identity.

#### Examples

##### EUID in `passwd`

### 3. Saved User ID
**Saved User ID** 

## Group ID

## Read Together
* (External Link) [What Are Unix PIDs and How Do They Work?](https://www.howtogeek.com/devops/what-are-unix-pids-and-how-do-they-work/)
