# Practice
## To Do
Here are a file "myfile.txt" and a subdirectory "mydir" in a practice directory, "C:\Users\reruo\testdir".

![beforelink](https://github.com/reruo321/OS-Self-Study/assets/48712088/1084f229-1f99-4505-82ca-c2bc53a895af)

![beforelinkcmd](https://github.com/reruo321/OS-Self-Study/assets/48712088/92553531-a8fc-4ed4-8dc8-21198bc7500c)

1. Create shortcuts, junctions, symbolic links, and hard links of "myfile.txt" and "mydir", using the File Explorer and the CMD. If a link type is not suitable for a file or a directory, DO NOT create it!
2. Display a list of a directory's files and subdirectories using the File Explorer and the CMD.

## Hints
### Hint 1: What to Link?
<details>
  <summary><b>SPOILERS</b></summary>

| | Shortcut | Junction | Symbolic Link | Hard Link |
|:-:|:-:|:-:|:-:|:-:|
| File Linking | O | X | O | O |
| Folder Linking | O | O | O | X |

We should create total 6 links.

</details>

### Hint 2: CMD Commands to Link
<details>
  <summary><b>SPOILERS</b></summary>

1. Shortcut:

    * File: Right-click the file and create.
    * Direcotry: Right-click the directory and create.

2. Junction:

    * File: -
    * Directory: Use the CMD
   
          mklink /j "YOUR_LINK" "TARGET_DIRECTORY"

3. Symbolic Link:

    * File: Use the CMD

          mklink "YOUR_LINK" "TARGET_FILE"

    * Directory: Use the CMD
   
          mklink /d "YOUR_LINK" "TARGET_DIRECTORY"

4. Hard Link:

    * File: Use the CMD

          mklink /h "YOUR_LINK" "TARGET_FILE"

    * Directory: -

</details>

### Hint 3: Displaying a Directory in the CMD
<details>
  <summary><b>SPOILERS</b></summary>

Type `dir` to display a list of a directory's files and subdirectories.

</details>

## Solution
<details>
  <summary><b>SPOILERS</b></summary>

### 

### Result


![afterlink](https://github.com/reruo321/OS-Self-Study/assets/48712088/c8f5beab-348b-4a1c-bb45-16abb44abdee)

![afterlinkcmd](https://github.com/reruo321/OS-Self-Study/assets/48712088/9e37d3bd-ce56-4bcb-a761-bc51a7225310)

</details>
