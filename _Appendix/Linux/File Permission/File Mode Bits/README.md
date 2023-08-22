# File Mode Bits
There are two parts of the file mode bits:

1. **File Permission Bits**
2. **Special Mode Bits**

Please read [here](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/File%20Permission) together to understand the file permissions!

## 1. File Permission Bits
A user can have three kinds of permissions for a file. They are used to control ordinary access to the file.

* ***read* permission**
* ***write* permission**
* ***execute* permission**

## 2. Special Mode Bits
These three special components of the file mode bits affect only executable files (programs), and on most systems, directories.

* **set-user-ID bit (`setuid` bit)**: On execution, set the process's EUID to file's EUID. `s` and `S` in the permission might imply this bit or `setgid` is ON.
* **set-group-ID bit (`setgid` bit)**: On execution, set the process's EGID to file's EGID. `s` and `S` in the permission might imply this bit or `setuid` is ON. `l` tells this bit is ON.
* **Sticky bit**: Gives permission to move or delete a file in the directory, only for the file owner. If a user want to move or delete a file, she must have *write* permission for the directory + be the owner of the file. The permission symbols `t` and `T` say this bit is ON.

## Read Together
* (External Link) [Mode Structure](https://www.gnu.org/software/coreutils/manual/html_node/Mode-Structure.html)
