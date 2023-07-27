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

## 2. Mandatory Locking
**Mandatory locking**

## Read Together
* (External Link) [Introduction to File Locking in Linux](https://www.baeldung.com/linux/file-locking)
