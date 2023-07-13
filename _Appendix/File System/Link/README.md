# Link
There are different kinds of link in file system. Note that even links with the same name may differ between file systems, OS types, and even version releases of the same OS.

1. Shortcut
2. Junction
3. Symbolic Link
4. Soft Link
5. Hard Link

## Windows
※ Note: The comparison is specific on the **NTFS file system**. Some old Windows releases under Vista may be unable to use these NTFS links.

| | Shortcut | Junction | Symbolic Link | Hard Link |
|:-:|:-:|:-:|:-:|:-:|
| Type | File | NTFS<br>File System<br>Object | NTFS<br>File System<br>Object | NTFS<br>File System<br>Object |
| File Linking | O | X | O | O |
| Folder Linking | O | O | O | X |
| Linking across<br>Hard Drivers | O | O<br>(on the same<br>computer) | O | X |
| Pointing to<br>Non-existent<br>Target | O | O | O | X |
| Relative Path<br>Support | X | X | O<br>(on the same<br>volume) | X |

Microsoft Official Guide for NTFS Links: https://learn.microsoft.com/en-us/windows/win32/fileio/hard-links-and-junctions

### 1. Shortcut
**Shortcut** is a file that points to a file or directory.

![win shortcut](https://github.com/reruo321/OS-Self-Study/assets/48712088/a99f8aa1-45dc-49a8-b8b4-eec2b418a99b)

The figure represents a shortcut of the *Microsoft Edge*, which executable file name is *msedge.exe*.

#### Creating a Shortcut
I will introduce three of the many ways to create a shortcut briefly.

1. Right-click the file/directory, and select "Create shortcut".
2. Right-click and drag the file/directory to preferred location. Select "Create shortcut here".
3. Right-click a File Explorer, choose "New" → "Shortcut" option, and type the target.

### 2. Junction
**Junction(NTFS junction point)** is a pointer to a directory on the local volume. It is processed at the server.

Open the CMD, and type this command to create a junction point to directory.

    mklink /j "YOUR_LINK" "ORIGINAL_DIRECTORY"

### 3. Symbolic Link
**NTFS symbolic link** was introduced in Windows Vista to replace junction points and hard links, to increase compatilibilty with Unix systems. Especially POSIX-compliant ones are not files but entries into the inode table. Also, while junction is processed at the server, symbolic link is done at the client.

Open the CMD, and type this command to create a symbolic link to a file/directory.

    :: file
    mklink "YOUR_LINK" "ORIGINAL_FILE"

    :: directory
    mklink /d "YOUR_LINK" "ORIGINAL_DIRECTORY"

### 4. Soft Link
**Soft link** means *junction* in Windows.

### 5. Hard Link

Open the CMD, and type this command to create a hard link to a file.

    mklink /h "YOUR_LINK" "ORIGINAL_FILE"

### Practice
#### To Do
Here are a file "myfile.txt" and a subdirectory "mydir" in a practice directory, "C:\Users\reruo\testdir".

![beforelink](https://github.com/reruo321/OS-Self-Study/assets/48712088/1084f229-1f99-4505-82ca-c2bc53a895af)

![beforelinkcmd](https://github.com/reruo321/OS-Self-Study/assets/48712088/92553531-a8fc-4ed4-8dc8-21198bc7500c)

1. Create shortcuts, junctions, symbolic links, and hard links of "myfile.txt" and "mydir", using the File Explorer and the CMD. If a link type is not for a file or a directory, DO NOT create it!
2. Display a list of a directory's files and subdirectories using the File Explorer and the CMD.

#### 

#### Result


![afterlink](https://github.com/reruo321/OS-Self-Study/assets/48712088/c8f5beab-348b-4a1c-bb45-16abb44abdee)

![afterlinkcmd](https://github.com/reruo321/OS-Self-Study/assets/48712088/9e37d3bd-ce56-4bcb-a761-bc51a7225310)

## Linux


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
