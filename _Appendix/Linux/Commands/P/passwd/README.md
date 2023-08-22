# `passwd`
`passwd` is used to change the password of a user account.
Only *root* has the privilege to change the password for any users on the system,
otherwise a normal user can change only the one for himself.

It's in the directory `/usr/bin/passwd`.

## Usage
To change your password:

    $ passwd

To change a user *TARGET_USER*'s password:

    $ passwd TARGET_USER
