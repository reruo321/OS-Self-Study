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

* Each permission set is represented as three octal digits.
* The octal digits individually represent the permissions for "user owner", "group owner", and "others".
* You can decide each digit value by following these rules:
  1. The initial value is 0, which means no permission will be granted for the user.
  2. To grant the *read* permission, add 4.
  3. To grant the *write* permission, add 2.
  4. To grant the *execute* permission, add 1.

### Examples

## 2. Symbolic Mode
**Symbolic mode** uses combinations of letters and symbols to add or remove permissions.

## Read Together
* (External Link) [Changing File Permissions](https://docs.oracle.com/cd/E19504-01/802-5750/6i9g464pv/index.html)
