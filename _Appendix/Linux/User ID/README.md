# User ID in Linux
**User ID(UID)** is a classification of users, and **group ID(GID)** is of groups in the kernel level of the Linux OS.
Both of them are translated to specific unsigned integer values,
which type is faster and smaller than string so that being preferred when passing the data.

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
**Effective User ID(EUID)** is an ID which is normally the same as *Real User ID*, but can be changed to give files accessing privilege to a user, which files can be only accessed by a privileged user. (Example: *root*)

We can know it by using a command, `whoami`.

    $ whoami

#### Examples

##### EUID in `passwd`

### 3. Saved User ID
**Saved User ID** 

## Group ID
