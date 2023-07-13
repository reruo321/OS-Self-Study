# Links in Windows
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

## 1. Shortcut
**Shortcut** is a file that points to a file or directory.

![win shortcut](https://github.com/reruo321/OS-Self-Study/assets/48712088/a99f8aa1-45dc-49a8-b8b4-eec2b418a99b)

The figure represents a shortcut of the *Microsoft Edge*, which executable file name is *msedge.exe*.

#### Creating a Shortcut
I will introduce three of the many ways to create a shortcut briefly.

1. Right-click the file/directory, and select "Create shortcut".
2. Right-click and drag the file/directory to preferred location. Select "Create shortcut here".
3. Right-click a File Explorer, choose "New" → "Shortcut" option, and type the target.

## 2. Junction
**Junction(NTFS junction point)** is a pointer to a directory on the local volume. It is processed at the server.

Open the CMD, and type this command to create a junction point to directory.

    mklink /j "YOUR_LINK" "TARGET_DIRECTORY"

## 3. Symbolic Link
**NTFS symbolic link** was introduced in Windows Vista to replace junction points and hard links, to increase compatilibilty with Unix systems. Especially POSIX-compliant ones are not files but entries into the inode table. Also, while junction is processed at the server, symbolic link is done at the client.

Open the CMD, and type this command to create a symbolic link to a file/directory.

    :: file
    mklink "YOUR_LINK" "TARGET_FILE"

    :: directory
    mklink /d "YOUR_LINK" "TARGET_DIRECTORY"

## 4. Soft Link
**Soft link** means *junction* in Windows.

## 5. Hard Link

Open the CMD, and type this command to create a hard link to a file.

    mklink /h "YOUR_LINK" "TARGET_FILE"
