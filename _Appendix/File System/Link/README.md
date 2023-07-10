# Link
There are different kinds of link in file system.

1. Shortcut
2. Junction
3. Symbolic Link (Soft Link)
4. Hard Link

## 1. Shortcut
**Shortcut** is a file that contains just path data.

* It can refer to destination via only an absolute path. (No relative path.)

It is supported only in Windows, and *symbolic link* is a substitution of it in Linux.

## 2. Junction
**Junction** is processed at the server.

## 3. Symbolic Link
**Symbolic link (soft link)** is a symbolic Linux/Unix link (file-system object in Windows) to point to a file or directory.

While it is supported in Linux, it has been also supported in Windows natively under NTFS, since Vista version.

### Symbolic Link vs Shortcut
It seems to be the same as shortcut, but actually there are some differences:

* It is a file-system level.
* Especially POSIX-compliant ones are not files but entries into the inode table.
* It can refer to destination via either an absolute or a relative path.

### Symbolic Link vs Junction

It is also different from junction in these ways.

* While junction is processed at the server, symbolic link is done at the client.

