# Links in Linux


## 1. Shortcut
**Shortcut** which we have seen in Windows is not officially supported in Linux. Users can either use the similar one - *symbolic link*, or make a shortcut-like thing manually. Users often uses the term "Linux *shortcut*" to describe *symbolic link*.

## 2. Junction
**Junction** is an NTFS specific terminology, so there's no official Linux support. We can use *symbolic link* instead, or install the 3rd-party application to support the junction point.
## 3. Symbolic Link
## 4. Soft Link
**Soft link** means *symbolic link* in Linux.
## 5. Hard Link
**Hard link** also exists in Linux, but only applied to files. (No directories.)

The command

    $ ls -l

on the terminal will show the number of (hard) links to a file/directory, next to the file/directory permission.
