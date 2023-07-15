# Practice 2
We made several kinds of Windows (NTFS) links from Practice 1.
Now we will see how links would change if their targets are moved or removed.
You can guess the answers of the practice by checking [this table](https://github.com/reruo321/OS-Self-Study/tree/main/_Appendix/File%20System/Link/Windows#links-in-windows)!

## TODO
※ We will use the files made from Practice 1.
### A. Tracking Information
1. Put a random file into "mydir". I put a file named "123.txt" as an example.
2. See information about the links carefully.

### B. Moving Targets
1. Move the targets, "myfile.txt" and "mydir" to the "Desktop", or other directory.
2. See what happened to each link.

### C. Removing Targets
1. Put the targets, "myfile.txt" and "mydir", into the "Recycle Bin".
2. See what happened to each link.
3. Completely delete the targets by emptying the "Recycle Bin".
4. See the links again.

### D. Recovering Targets
1. Create "myfile.txt" and "mydir" (with "123.txt") in the practice directory, "testdir" again.
2. Type something in the "myfile.txt". Text should be different from the former!
3. See what happened to each link.

### E. Moving Links
1. Remove all links, and create them again in "testdir".
2. Move all links to the "Desktop", or other directory.
3. Open "myfile.txt" and change the text.
4. Create the second random file in "mydir". I named the file as "456.txt".
5. See what happened to all targets and all links.
6. Put all links into "testdir" again.
7. See what happened to all things. If there were any change, which one made it?

## Result
<details><summary>SPOILERS</summary>
### 1-a. Shortcut - File

![shortf see](https://github.com/reruo321/OS-Self-Study/assets/48712088/25a5981f-621e-4b0d-896f-bdbd2ec3eb83)



### 1-b. Shortcut - Directory
![shortd see](https://github.com/reruo321/OS-Self-Study/assets/48712088/a9b759d5-ba6a-4d08-900c-afd53f864674)

### 2. Junction
![junc see](https://github.com/reruo321/OS-Self-Study/assets/48712088/e4c378d7-6c6f-436f-82fb-d3fee93eb48e)

#### 3-a. Symbolic Link - File
![symf see](https://github.com/reruo321/OS-Self-Study/assets/48712088/45db1d20-38bf-4a2a-a976-bde3f7f39e10)

#### 3-b. Symbolic Link - Directory
![symd see](https://github.com/reruo321/OS-Self-Study/assets/48712088/616b545e-c974-4c2b-94d5-f5e01409e4d9)

#### 4. Hard Link
![hard see](https://github.com/reruo321/OS-Self-Study/assets/48712088/34b33666-dc6d-43c4-81c2-c9e374fc7304)

</details>
