# `chmod`
`chmod` changes the file mode bits of each given file according to mode.

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
TODO: Using the absolute mode of `chmod`, set permissions of a file "example_one" like this:

  1. Grant the *read*, *write*, and *execute* permissions for user owner.
  2. Grant the *read* permission for group owner.
  3. Grant the *read* permission for others.

Let's find the answer step by step.

1. User owner: 4 (read) + 2 (write) + 1 (execute) = 7
2. Group owner: 4 (read) = 4
3. Others: 4 (read) = 4

Therefore, you should type the command in the terminal like this.

    $ chmod 744 example_one

#### Example 2
TODO: Using the absolute mode of `chmod`, set permissions of a file "example_two" as "-rwxr-----".

Split the final file permissions, and finding the answer will be a piece of cake!

1. User owner: "rwx", 4 (read) + 2 (write) + 1 (execute) = 7
2. Group owner: "r--", 4 (read) = 4
3. Others: "---", No permission, 0

Therefore, you should type the command in the terminal like this.

    $ chmod 740 example_two

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
     * `l`: [Mandatory Locking](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/File%20Locking). The file must be a regular file with "set-group-ID bit ON + group execute permission OFF".
     * `s`:

* The octal digits individually represent the permissions for "user owner", "group owner", and "others".
* You can decide each digit value by following these rules:
  1. The initial value is 0, which means no permission will be granted for the user.
  2. To grant the *read* permission, add 4.
  3. To grant the *write* permission, add 2.
  4. To grant the *execute* permission, add 1.

## Read Together
* (External Link) [Changing File Permissions](https://docs.oracle.com/cd/E19504-01/802-5750/6i9g464pv/index.html)
* [File Locking](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/File%20Locking)
