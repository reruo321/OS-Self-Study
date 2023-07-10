# Link
There are different kinds of link in file system. Note that even links with the same name may differ between the OSs.

1. Shortcut
2. Junction
3. Symbolic Link (Soft Link)
4. Hard Link

## Windows
※ Note: The comparison is specific on NTFS links.

| | Shortcut | Junction | Symbolic Link | Hard Link |
|:-:|:-:|:-:|:-:|:-:|
| Type | File | | File-system Level | 
| File Linking | O | X | O | O |
| Folder Linking | O | O | O | X |
| Linking across<br>Hard Drivers | O | O<br>(on the same<br>computer) | O | X |
| Pointing to<br>Non-existent<br>Target | O | O | O | X |
| Relative Path<br>Support | X | X | O<br>(on the same<br>volume) | X |

* *Soft link* in Windows refers to *junction*.


## Linux
| | Shortcut | Junction | Symbolic Link | Hard Link |
|:-:|:-:|:-:|:-:|:-:|
| Type | File | | File-system Level | 
| Target | | Directory | File<br>Directory | |
| Supporting OS | Windows | Windows | Windows<br>Linux<br>Unix | Windows<br>Linux |

* *Soft link* in Windows refers to *symbolic link*.

## 1. Shortcut
**Shortcut** is a file that contains just path data.

* It can refer to destination via only an absolute path. (No relative path.)

It is supported only in Windows, and *symbolic link* is a substitution of it in Linux.

## 2. Junction
**Junction** is processed at the server.

* It is processed at the server.
* It can point to directory.

## 3. Symbolic Link
**Symbolic link (soft link)** is a link to point to a file or directory.

In Linux/Unix, it is a pointer. In Windows, it is a file-system object, being supported natively under NTFS since Vista version.

### vs Shortcut
It seems to be the same as shortcut, but actually there are some differences:

* It is a file-system level.
* Especially POSIX-compliant ones are not files but entries into the inode table.
* It can refer to destination via either an absolute or a relative path.

### vs Junction

It is also different from junction in several ways.

* While junction is processed at the server, symbolic link is done at the client.

## 4. Hard Link
**Hard link**

It also exists in Linux, but only applied to files. (No directories.)
