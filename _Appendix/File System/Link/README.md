# Link
There are different kinds of link in file system. Note that even links with the same name may differ between file systems, OS types, and even version releases of the same OS.

1. Shortcut
2. Junction
3. Symbolic Link
4. Soft Link
5. Hard Link

## Windows
※ Note: The comparison is specific on NTFS links.

| | Shortcut | Junction | Symbolic Link | Hard Link |
|:-:|:-:|:-:|:-:|:-:|
| Type | File | NTFS<br>File System<br>Object | NTFS<br>File System<br>Object | NTFS<br>File System<br>Object |
| File Linking | O | X | O | O |
| Folder Linking | O | O | O | X |
| Linking across<br>Hard Drivers | O | O<br>(on the same<br>computer) | O | X |
| Pointing to<br>Non-existent<br>Target | O | O | O | X |
| Relative Path<br>Support | X | X | O<br>(on the same<br>volume) | X |

### 1. Shortcut
**Shortcut** is a file that points to a file or directory.

![win shortcut](https://github.com/reruo321/OS-Self-Study/assets/48712088/a99f8aa1-45dc-49a8-b8b4-eec2b418a99b)

The figure represents a shortcut of the *Microsoft Edge*, which executable file name is *msedge.exe*.

### 2. Junction
**Junction(NTFS junction point)** is a pointer to a directory on the local volume. It is processed at the server.

### 3. Symbolic Link
**NTFS symbolic link** was introduced in Windows Vista to replace junction points and hard links, to increase compatilibilty with Unix systems. Especially POSIX-compliant ones are not files but entries into the inode table. Also, while junction is processed at the server, symbolic link is done at the client.

### 4. Soft Link
**Soft link** means *junction* in Windows.

### 5. Hard Link

## Linux
| | Shortcut | Junction | Symbolic Link | Hard Link |
|:-:|:-:|:-:|:-:|:-:|
| Type | File | | File-system Level | |
| Target | | Directory | File<br>Directory | |
| Supporting OS | Windows | Windows | Windows<br>Linux<br>Unix | Windows<br>Linux |

### 1. Shortcut
**Shortcut** which we have seen in Windows is not officially supported in Linux. Users can either use the similar one - *symbolic link*, or make a shortcut-like thing manually. Users often uses the term "Linux *shortcut*" to describe *symbolic link*.

### 2. Junction
**Junction** is an NTFS specific terminology, so there's no official Linux support. We can use *symbolic link* instead, or install the 3rd-party application to support the junction point.
### 3. Symbolic Link
### 4. Soft Link
**Soft link** means *symbolic link* in Linux.
### 5. Hard Link
**Hard link** also exists in Linux, but only applied to files. (No directories.)

The command

    $ ls -l

on the terminal will show the number of (hard) links to a file/directory, next to the file/directory permission.
