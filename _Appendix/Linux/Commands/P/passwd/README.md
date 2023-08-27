# `passwd`
`passwd` is used to change the password of a user account.
Only *root* has the privilege to change the password for any users on the system,
otherwise a normal user can change only the one for himself.

It's in the directory `/usr/bin/passwd`.

## Conditions
There are two conditions that the command allows a user to change the user password.

1. The user is *root*.
2. The UID of a user (target to change the password) is the same as the current real UID.

You can check them by seeing the [source code, passwd.c](https://github.com/shadow-maint/shadow/blob/f76c31f50ed0cca018591cc2d0b43837d6224f7d/src/passwd.c#L990C2-L1004C1).

Note that the user owner of `passwd` is *root*, and when a non-*root* user uses the command, she will get the *root*'s effective UID. Meanwhile, the real UID remains as the non-*root* user's one. (See [here](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/Identifier#-euid-in-passwd) to understand the concept of UID.)

If *root* is willing to use `passwd`, it can change any user passwords in the system.

Now suppose that a non-*root* user *mincho* tries to modify someone's password. She will get the effective UID of *root*, but the real UID is still *mincho*'s. Even if *mincho* temporarily got *root*'s EUID, she is not acutally *root*, so she can change a password only when the UID of a user is the same as the current real UID, *mincho*'s UID. Of course, it is okay when *mincho* changes her own password. However, because every UID is unique, *mincho* can never have the same UID as any others. Therefore, unless she switches to *root* with the command `su`, she cannot change other users' password.

## Usage
To change your password:

    $ passwd

To change a user *TARGET_USER*'s password:

    $ passwd TARGET_USER

## Read Together
* (Other's Github Repository) [passwd.c](https://github.com/shadow-maint/shadow/blob/master/src/passwd.c) - The source code of `passwd`.
* [Identifier](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/Linux/Identifier#-euid-in-passwd) - This includes an example with `passwd` to understand UID.
