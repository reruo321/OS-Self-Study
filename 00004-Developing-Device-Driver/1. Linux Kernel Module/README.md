# 1. Linux Kernel Module
We need to develop a Linux kernel module before developing a device driver.

* **Kernel Integration**: Linux Device drivers are part of the kernel, and need to be integrated with the kernel's core to interact with hardware effectively. Dynamic loading on a kernel module allows it to extend the functionality of the Linux kernel at runtime for the interaction.
* **Dynamic Loading**: When load and unload a kernel module dynamically, it does not need to reboot the system.
* **Kernel Space Access**: Device drivers operate in the kernel space instead of user space. It provides security and stability.
* **Isolation**: Since kernel modules provide a level of isolation on device drivers from the rest of the kernel, we can protect the kernel from potential issues and security vulnerabilities from them. Even if the drivers cause bug or crashes, we can recover it by unloading the module.
* **Avoiding Monolithic Kernel Changes**: It avoids making changes directly to the Linux kernel whose design is monolithic.

## Implementation
Here are a list of some features we can implement on a Linux kernel module.

1. ★ Module Initialization
2. ★ Module Loading
3. ★ Device Registration
4. Character Device Registration
5. Input Handling
6. Polling (just leave it on comment)
7. Interrupt Handling
8. Input Event Generation
9. User-Space Interface
10. Locking
11. Error Handling
12. Security
13. Licensing
14. ★ Device Unregistration
15. ★ Module Unloading
16. ★ Cleanup and Exit
