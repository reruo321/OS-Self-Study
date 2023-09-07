# Shell-Spawning Code (Version. 1)

* (SPOILER) Reference: [0x2a4 Shell-Spawning Code](https://bista.sites.dmi.unipg.it/didattica/sicurezza-pg/buffer-overrun/hacking-book/0x2a0-writing_shellcode.html)

## TODO
1. Before you start, ensure that you are a non-*root* user!
2. Write a shellcode that spawns shell on **x86**, and compile it.
3. Execute the program, and check if the program spawns a shell correctly.
4. Check the username of the current user with a command. Exit the shell.
5. Switch your account to *root*, and do the Step 3-4 again. Is there any change?
6. With being granted *root* privilege temporarily, change the owner of the program as *root*.
7. With being granted *root* privilege temporarily, set a flag to allow a non-*root* user to run the program with temporarily elevated privilege, *root*.
8. Execute the program as a non-*root* user again, and check the username of the current user with a command. Are you *root* or not?

### Constraints
1. Define a string `fpath = "(PATH)XXXXAAAABBBB"` at a section.
2. Use `fpath` for ALL arguments that load an address.
