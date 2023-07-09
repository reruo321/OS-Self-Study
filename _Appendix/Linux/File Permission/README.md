# File Permission in Linux
## Command
    $ ls -l

`ls`'s `-l` option does "long listing", so you can see the metadata of Linux files including permissions with this command.

## How to View
![drawpermission](https://github.com/reruo321/OS-Self-Study/assets/48712088/8863ddef-5a3d-4b26-9262-e47e9432508b)

The system validates a user's permissions from left to right. For example, if one is the user that owns the file, his permissions is granted as "user owner"'s, and no further checks will be done. If not, it checks his group membership. If he is not a "group owner" either, he gets "others" permissions.
