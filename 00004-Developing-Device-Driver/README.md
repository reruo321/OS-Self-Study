# Developing Device Driver
Device driver enables a kernel to communicate with hardwares. The programming is a part of kernel programming.

1. Develop a **Linux kernel module**.
2. Create a **virtual device** using the kernel module.
3. Develop a **device driver**.

## Steps
1. Set environment, including a compiler, kernel header files, and other tools.
2. Develop a Linux kernel module! Its extension will be `.c`. Define initialization functions and cleanup (exit) function.
3. Compile the module. It should be able to access the kernel header files.
4. Load the kernel module to the Linux kernel. Commands such as `insmod` or `modprobe` will be used.
5. When finishing to load the module, virtual device will be added to the system. Register it with the kernel with a command like `register_chrdev`.
