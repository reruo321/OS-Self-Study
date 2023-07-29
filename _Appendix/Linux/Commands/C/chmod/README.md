# `chmod`
`chmod` (abbreviation of **ch**ange **mod**e) changes the file mode bits of each given file according to mode.

Set permissions in either of these two modes:

* Absolute Mode
* Symbolic Mode

See [this website](https://docs.oracle.com/cd/E19504-01/802-5750/6i9g464pv/index.html) to see full description.

## 1. Absolute Mode
**Absolute mode** uses octal numbers to represent file permissions.

    (Syntax)
    $ chmod [permission set] [target file/directory]
    
    (Example)
    $ chmod 754 myfile

* Only the current owner of the file or superuser can use the command to change file permissions.
* Each permission set is represented as three octal digits.
* The octal digits individually represent the permissions for "user owner", "group owner", and "others".
* You can decide each digit value by following these rules:
  1. The initial value is 0, which means no permission will be granted for the user.
  2. To grant the *read* permission, add 4.
  3. To grant the *write* permission, add 2.
  4. To grant the *execute* permission, add 1.

### Examples
#### Example 1
TODO: Using the absolute mode of `chmod`, set permissions of a file "abs_one" like this:

  1. Assign the *read*, *write*, and *execute* permissions to user owner.
  2. Assign the *read* permission to group owner.
  3. Assign the *read* permission to others.

Let's find the answer step by step.

1. User owner: 4 (read) + 2 (write) + 1 (execute) = 7
2. Group owner: 4 (read) = 4
3. Others: 4 (read) = 4

Therefore, you should type the command in the terminal like this.

    $ chmod 744 abs_one

#### Example 2
TODO: Using the absolute mode of `chmod`, set permissions of a file "abs_two" as "-rwxr-----".

Split the final file permissions, and finding the answer will be a piece of cake!

1. User owner: "rwx", 4 (read) + 2 (write) + 1 (execute) = 7
2. Group owner: "r--", 4 (read) = 4
3. Others: "---", No permission, 0

Therefore, you should type the command in the terminal like this.

    $ chmod 740 abs_two

## 2. Symbolic Mode
**Symbolic mode** uses combinations of letters and symbols to add or remove permissions.

    (Syntax)
    $ chmod [symbolic_mode who][symbolic_mode operator][symbolic_mode permission] [target file/directory]
    
    (Example)
    $ chmod a+r myfile
    $ chmod o-x myfile
    $ chmod g=rwx myfile

* Only the current owner of the file or superuser can use the command to change file permissions.
* Three functions are needed: *Who*, *Operator*, and *Permission*.
  1. ***Who***: Specifies whose permissions are changed.
     * `u`: User Owner
     * `g`: Group Owner
     * `o`: Others
     * `a`: All
  2. ***Operator***: Specifies the operation to perform.
     * `=`: Assign
     * `+`: Add
     * `-`: Remove
  3. ***Permission***: Specifies what permissions are changed.
     * `r`: Read
     * `w`: Write
     * `x`: Execute
     * `l`: [Mandatory Locking](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/File%20Locking). The file must be a regular file with "`setgid` bit ON" AND "group execute permission OFF".
     * `s`: "`setuid` is ON" OR "`setgid` is ON".
     * `S`: "`setuid` is ON" AND "user execution bit is OFF". This is a kind of alert for perhaps wrong setting, because `setuid` is almost useless for an inexecutable file.
     * `t`: "Sticky bit is ON" AND "execution bit for others is ON".
     * `T`: "Sticky bit is ON" AND "execution bit for others is OFF".

### Examples
#### Example 1
TODO: Using the symbolic mode of `chmod`, set permissions of a file "sym_one" like this:

  1. Assign the *read*, *write*, and *execute* permissions to user owner.
  2. Assign the *read* permission to group owner.
  3. Assign the *read* permission to others.

Let's find the answer step by step.

1. User owner: r (read), w (write), x (execute)
2. Group owner: r (read)
3. Others: r (read)

Therefore, you should type the command in the terminal like this.

    $ chmod u=rwx, go=r sym_one

#### Example 2
TODO: Using the symbolic mode of `chmod`, set permissions of a file "sym_two" like this:

  1. Add the *execute* permission to user owner.
  2. Remove the *write* and *execute* permission from others.

Let's find the answer step by step.

1. User owner: +x
2. Others: -wx

Therefore, you should type the command in the terminal like this.

    $ chmod u+x, o-wx sym_two

#### Example 3
TODO: Using the symbolic mode of `chmod`, set permissions of a file "sym_three" like this:

  1. Remove the *execute* permission from all users.

Let's find the answer right now!

1. All: -x

Therefore, you should type the command in the terminal like this.

    $ chmod a-x sym_three

#### Example 4
TODO: Using the absolute mode of `chmod`, change permissions of a file "sym_two" from "-rw-rw-rw-" to "-rwxr--r--".

Let's find the answer step by step.

1. User owner: +x
2. Group owner: -w
3. Others: -w

Therefore, you should type the command in the terminal like this.

    $ chmod u+x, go-w sym_four

## Read Together
* (External Link) [Changing File Permissions](https://docs.oracle.com/cd/E19504-01/802-5750/6i9g464pv/index.html)
* [File Mode Bits](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/File%20Mode%20Bits)
* [File Permission in Linux](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/File%20Permission)
* [File Locking](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/File%20Locking)

