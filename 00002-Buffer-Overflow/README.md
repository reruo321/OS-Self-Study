# Buffer Overflow
**Buffer overflow** is an anomaly which happens when a program writing data to a buffer exceeds its allocated memory. There are two types of buffer overflows: stack-based and heap-based.

## Stack Buffer Overflow
We have learned that stack stores much information, such as local variables, saved registers, and return address.
If you try to store input more than buffer's storage capacity, without bounds checking, buffer overflow occurs and some of it on the stack will be overwritten. Then the vulnerability is used for stack exploitation!
Improper using of many C library functions including `strcpy`, `strcat`, and `sprintf` can be a cause of buffer overflow, since there is no way to protect against the anomaly by checking the buffer and the input size.

### Return-Oriented Programming
**Return-oriented programming (ROP)** is an stack exploit technique that allows an attacker to execute *exploit code*, and to do control-flow hijacking. After overwriting the return address with the exploit code pointer, running `ret` instruction will jump the program to the exploit code.

## Defenses
### ASLR
**Address Space Layout Randomization (ASLR)** is a computer security technique that randomly arranges the address space positions of key data of a process including:

* Program Code
* Library Code
* Stack
* Global Variables
* Heap Data

Here are some characteristics of ASLR.

* Increases security by making the address harder to predict.
* Modern Linux kernels have it enabled by default.
* Focuses on preventing exploitation. Not on trapping, alerting, or giving information on attack.
* Low entropy in 32-bit systems, because of small range of random addresses.

#### Entropy
**Entropy** has many meaning, and it means the randomness of an OS or an application in computing.
It is used in cryptography or others where random data are needed.

#### NOP Sled
