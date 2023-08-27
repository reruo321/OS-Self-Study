# `passwd`
`passwd` is used to change the password of a user account.
Only *root* has the privilege to change the password for any users on the system,
otherwise a normal user can change only the one for himself.

It's in the directory `/usr/bin/passwd`.

## Conditions
There are two conditions that the command allows a user to change the user password. ([Reference](https://github.com/shadow-maint/shadow/blob/f76c31f50ed0cca018591cc2d0b43837d6224f7d/src/passwd.c#L990C2-L1004C1))

1. The user is *root*.
2. The UID of the user is the same as the current real UID.

## Usage
To change your password:

    $ passwd

To change a user *TARGET_USER*'s password:

    $ passwd TARGET_USER

## Read Together
* (Other's Github Repository) [passwd.c](https://github.com/shadow-maint/shadow/blob/master/src/passwd.c)
