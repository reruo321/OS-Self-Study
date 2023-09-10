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
1. Declare just one variable; define a string something like `fpath = "(PATH)XXXXAAAABBBBCCCC"`. You can adjust the masking alphabet part. (Example: /my/path/helloXABBCCCCD)
2. Use `fpath` for ALL arguments that load an address.

## Hints
<details>
  <summary><b>SPOILERS</b></summary>

### Hint 1: System Calls
    // NR = 70
    int setreuid(uid_t ruid, uid_t euid);

    // NR = 11
    int execve(const char *pathname, char *const _Nullable argv[],
                  char *const _Nullable envp[]);

### Hint 2: Section
1. `.data`: The data section

    a. String "/bin/shXXXX" (Note: Just an example for the hint! Might not be the final.)
   
2. `.text`: The code section

    a. `.global`: `_start` (The entry point of the program)
  
    b. `_start`

    * int setreuid(uid_t *ruid*, uid_t *euid*);
    * int execve(const char **pathname*, char **const* _Nullable *argv[]*, char *const _Nullable *envp[]*);

### Hint 3: Other Assembly Hints
#### `setreuid`
Linux manual page: [setreuid](https://man7.org/linux/man-pages/man2/setreuid.2.html)

* 

### Hint 4: Execution

1. Compile & Execute

   a. `gcc`: GNU Compiler. Need to generate code for IA-32 architecture.

   b. `ld`: GNU Linker. Need to output 32-bit code.

   c. Execute the output



</details>
