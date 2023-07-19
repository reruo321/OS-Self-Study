# File Permission in Linux
## Command
    $ ls -l

`ls`'s `-l` option does "long listing", so you can see the metadata of Linux files including permissions with this command.

![lsl](https://github.com/reruo321/OS-Self-Study/assets/48712088/2f6ff73d-61a5-4d54-af5c-d3094ea7a209)

![lsl](https://github.com/reruo321/OS-Self-Study/assets/48712088/4bd5a41f-65e4-4669-bde7-583505793a52)

(See [here](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/File%20System/Link/Linux) for understanding "links".)

p.s. If you want to see long listing of a directory "MY_DIRECTORY" without other files, use

    $ ls -ld

## How to View
![drawpermission](https://github.com/reruo321/OS-Self-Study/assets/48712088/8863ddef-5a3d-4b26-9262-e47e9432508b)

The system validates a user's permissions from left to right. For example, if one is the user that owns the file, his permissions is granted as "user owner"'s, and no further checks will be done. If not, it checks his group membership. If he is not a "group owner" either, he gets "others" permissions.

The 1st permission **r** is *read*, the 2nd **w** is *write*, and the 3rd **x** is *execute*. Omitted alphabet means no permission to do it. For instance, *r-x* means a user has **r**ead permission and e**x**ecute permission, but no **w**rite one.

### Examples
![lsl](https://github.com/reruo321/OS-Self-Study/assets/48712088/2f6ff73d-61a5-4d54-af5c-d3094ea7a209)

I brounght three examples from my Ubuntu.

#### Example 1
See the permissions of ***spawn1***.

> -rwxrwxr-x

Divide it into four parts: *-*, *rwx*, *rwx*, *r-x*.
1. *-*: *spawn1* is a **File**.
2. *rwx*: Permission for **User owner**: Read O / Write O / Execute O
3. *rwx*: Permission for **Group owner**: Read O / Write O / Execute O
4. *r-x*: Permission for **Others**: Read O / Write X / Execute O

#### Example 2
See the permissions of ***spawn1.o***.

> -rw-rw-r--

Divide it into four parts: *-*, *rw-*, *rw-*, *r--*.
1. *-*: *spawn1.o* is a **File**.
2. *rw-*: Permission for **User owner**: Read O / Write O / Execute X
3. *rw-*: Permission for **Group owner**: Read O / Write O / Execute X
4. *r--*: Permission for **Others**: Read O / Write X / Execute X

#### Example 3
See the permissions of ***test***.

> drwxrwxr-x

Divide it into four parts: *d*, *rwx*, *rwx*, *r-x*.
1. *d*: *test* is a **Directory**.
2. *rwx*: Permission for **User owner**: Read O / Write O / Execute O
3. *rwx*: Permission for **Group owner**: Read O / Write O / Execute O
4. *r-x*: Permission for **Others**: Read O / Write X / Execute O
   
