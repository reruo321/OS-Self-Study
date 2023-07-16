# Links in Linux
There are mainly two types of link in Linux: **Symbolic Link** and **Hard Link**.

|| Symbolic Link | Hard Link |
|:-:|:-:|:-:|
| Synonym | Soft Link<br>Linux Shortcut | - |
| File Linking | O | O |
| Directory Linking | O | X |

## 1. Shortcut
**Shortcut** which we have seen in Windows is not officially supported in Linux. Users can either use the similar one - *symbolic link*, or make a shortcut-like thing manually. Users often uses the term "Linux *shortcut*" to describe the *symbolic link*.

## ~~2. Junction~~
**Junction** is an Windows NTFS specific terminology, and there's no official Linux support. We can use *symbolic link* instead, or install the 3rd-party application to support the junction point.

## 3. Symbolic Link
**Symbolic link** is a pointer to a path to the data.

## 4. Soft Link
**Soft link** means *symbolic link* in Linux.

## 5. Hard Link
**Hard link**  is a link which refers to the data itself.

The command

    $ ls -l

on the terminal will show the files in a long listing format, and

    $ ls -ld MY_DIRECTORY

will show information of a directory, "MY_DIRECTORY". Here, we can see the number of hard links to the file/directory, next to the file/directory permission!
