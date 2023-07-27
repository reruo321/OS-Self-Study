# File Locking
**File locking** is a mechanism to avoid synchronization problem, restricting concurrent access to a file among multiple processes.
In other words, it allows only one process to access the file in a specific time.

Two kinds of file locks are supported in Linux.

* Advisory Locking
* Mandatory Locking

## 1. Advisory Locking
**Advisory locking** is a lock in which the OS keeps track of the locks, but does not enforce them.
It will work only if the processes sharing the same file are cooperating by explicitly acquiring locks.
A process which is not cooperating can ignore the lock, and it is free to read, write, execute, or even delete the file via system calls.

### Setting
If a record lock is not mandatory, it must be advisory. 

## 2. Mandatory Locking
**Mandatory locking** is a lock in which the OS enforces the file locking. Unlike advisory locking, it does not require any cooperation between processes sharing the same file.

Warning: The Linux implementation of mandatory locking is unreliable. ([Reference](https://man7.org/linux/man-pages/man2/fcntl.2.html))
### Setting
* [Using `chmod`](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/Commands/C/chmod). The file must be a regular file with "set-group-ID bit ON + group execute permission OFF" for mandatory locks, or the record locks will be advisory.

## Read Together
* (External Link) [Introduction to File Locking in Linux](https://www.baeldung.com/linux/file-locking)
* (External Link) [fcntl(2) — Linux manual page](https://man7.org/linux/man-pages/man2/fcntl.2.html)
* [`chmod`](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/Commands/C/chmod)
