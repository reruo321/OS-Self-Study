# Link
There are different kinds of link in file system.

1. Shortcut
2. Junction
3. Symbolic Link (Soft Link)
4. Hard Link

## 1. Shortcut
**Shortcut** is a file that contains just path data.

* It can refer to destination via only an absolute path. (No relative path.)

It exists only in Windows, and *symbolic link* is a substitution of it in Linux.

## 2. Junction
**Junction** is processed at the server.

## 3. Symbolic Link
**Symbolic link (soft link)**.

* It can refer to destination via either an absolute or a relative path.
* Especially POSIX-compliant ones are not files but entries into the inode table.
* 

 Although it seems to behave the same as junction, it is processed at the client.
Windows has also supported symbolic link natively under NTFS, since Vista version.
