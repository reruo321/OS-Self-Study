# File Mode Bits
There are two parts of the file mode bits:

1. **File Permission Bits**
2. **Special Mode Bits**

Please read [here](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/File%20Permission) together to understand the file permissions!

## 1. File Permission Bits
A user can have three kinds of permissions for a file. They are used to control ordinary access to the file.

* ***read* permission**
* ***write* permission**
* ***execute* permission**

## 2. Special Mode Bits
These three special components of the file mode bits affect only executable files (programs), and on most systems, directories.

* **set-user-ID bit (`setuid` bit)**: On execution, set the process's EUID to file's EUID. `s` and `S` in the permission might imply this bit or `setgid` is ON.
* **set-group-ID bit (`setgid` bit)**: On execution, set the process's EGID to file's EGID. `s` and `S` in the permission might imply this bit or `setuid` is ON. `l` tells this bit is ON.
* **Sticky bit**: Gives permission to move or delete a file in the directory, only for the file owner. If a user want to move or delete a file, she must have *write* permission for the directory + be the owner of the file. The permission symbols `t` and `T` say this bit is ON.

### Example - Sticky Bit
Suppose that you are a user called *reruo*. There are two directories, *alldir* and *reruodir*. *alldir* has a file named *ok.txt*, and *reruodir* has *dont_touch.txt*. Let both of the text files have the permission as `-rwxrwxrwx`.

![chmod 777](https://github.com/reruo321/OS-Self-Study/assets/48712088/d3d6cf51-7ed7-461b-9ea2-cbff6588c34a)

Next, set the permissions of the directories as `drwxrwxrwx`. After that, make the sticky bit is ON for *reruodir* like this:

    $ chmod +t reruodir

![chmod t](https://github.com/reruo321/OS-Self-Study/assets/48712088/6b09bad0-c590-436d-be92-cb53b84bd100)

Then the permissions for *reruodir* will be `drwxrwxrwt`.

Now, let's log in as another user, *guest1*. Try to write something on, and move or delete *ok.txt* and *dont_touch.txt*.

![dont touch](https://github.com/reruo321/OS-Self-Study/assets/48712088/c03bf42a-3221-4256-8298-31aaba23c4e2)

![mv result](https://github.com/reruo321/OS-Self-Study/assets/48712088/bb18b579-698d-4c2b-8321-0a63b954cd66)

As a result, *guest1* user can write both on *ok.txt* and *dont_touch.txt*. She can also move or delete *ok.txt*. However, she can not move or delete *dont_touch.txt*, and the system says they are not allowed commands.

## Read Together
* (External Link) [Mode Structure](https://www.gnu.org/software/coreutils/manual/html_node/Mode-Structure.html)
