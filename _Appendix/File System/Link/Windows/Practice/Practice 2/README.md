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

### C. Deleting Targets
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

### 1-a. Shortcut - File

<details><summary>SPOILERS</summary>

![shortf see](https://github.com/reruo321/OS-Self-Study/assets/48712088/25a5981f-621e-4b0d-896f-bdbd2ec3eb83)

Executing the shortcut opens its target, "myfile.txt".

![shortf move](https://github.com/reruo321/OS-Self-Study/assets/48712088/316ca9b9-b0fb-46e8-b324-4bea32f948a4)

After moving its target "myfile.txt", the new target became "hardlink.txt".

![shortf move](https://github.com/reruo321/OS-Self-Study/assets/48712088/bc92fb50-0eae-4a5f-ad17-ecd8e525c420)

After deleting its target "myfile.txt", the new target became "hardlink.txt".

![shortf after](https://github.com/reruo321/OS-Self-Study/assets/48712088/e79f28b7-9fb8-442b-a680-a9f7608b9ef8)

Even if "myfile.txt" is created again, the shortcut still points to "hardlink.txt".

![shortf selfmove](https://github.com/reruo321/OS-Self-Study/assets/48712088/90a8085a-0c24-4fbf-ac1a-ac53f7b34287)

Although the shortcut is moved, it still points to "myfile.txt".

</details>

### 1-b. Shortcut - Directory

<details><summary>SPOILERS</summary>

![shortd see](https://github.com/reruo321/OS-Self-Study/assets/48712088/06bec10e-2b94-48c6-adb2-cd553565874a)

Executing the shortcut opens its target, "mydir".

![shortd move](https://github.com/reruo321/OS-Self-Study/assets/48712088/995f6d6a-fd8a-4a58-8dc8-7c4a5e26e74f)

Even if its target "mydir" is moved, the shortcut still points to it.

![shortd remove](https://github.com/reruo321/OS-Self-Study/assets/48712088/bf5424cb-080a-456e-a113-5413f58fa365)

After moving its target "mydir" to the "Recycle Bin", an error message pops up. It asks whether you recover the target, or delete the shortcut.

![shortd comremove](https://github.com/reruo321/OS-Self-Study/assets/48712088/b6d8f784-10f0-4c1e-b13d-301fc4374d39)

When its target is completely deleted, another error message pops up. It asks whether you delete the shortcut or not.

![shortd see](https://github.com/reruo321/OS-Self-Study/assets/48712088/9057e4c4-bfc8-4538-a652-0965f4fbef8b)

When "mydir" is created again, the shortcut points to it again.

![shortd selfmove](https://github.com/reruo321/OS-Self-Study/assets/48712088/59614b88-0211-49c9-beaf-86a3aa789570)

Although the shortcut is moved, it still points to "mydir".

</details>

### 2. Junction

<details><summary>SPOILERS</summary>

![junc see](https://github.com/reruo321/OS-Self-Study/assets/48712088/696d6d6c-cc74-47cd-b422-c64e175c6e36)

Executing the junction opens "junc". Except the directory, it looks the same as "mydir".

![junc move](https://github.com/reruo321/OS-Self-Study/assets/48712088/9fb9e94c-9b3a-426c-ae53-d27be41b80f0)

After moving its target "mydir", the junction becomes unavailable and an error message pops up.

![junc move](https://github.com/reruo321/OS-Self-Study/assets/48712088/137f106f-bc33-4ab8-883c-696020ea540d)

After deleting its target "mydir", the junction becomes unavailable and an error message pops up.

![junc see](https://github.com/reruo321/OS-Self-Study/assets/48712088/3a052d06-5472-4063-88cb-f08aeedfe3d5)

If "mydir" is created again, the junction points to "mydir".

#### Moving the Junction

When you move the junction, it remains but...

**OH, NO!**

![mydir selfmove](https://github.com/reruo321/OS-Self-Study/assets/48712088/7ed98490-4da3-4e08-a004-b7646a4fb87e)

![junc selfmove testdir](https://github.com/reruo321/OS-Self-Study/assets/48712088/298a1b2b-b3df-4532-9b1d-da0bd7e39402)

The file in "mydir", "123.txt" disappears! No file in the junction in "testdir", neither.

![junc selfmove](https://github.com/reruo321/OS-Self-Study/assets/48712088/3c5b2cd7-9ef2-4399-8321-3bc5b6984c6a)

Meanwhile, another junction is created in the "Desktop", keeping the file "123.txt" in it.

![mydir selfmove after](https://github.com/reruo321/OS-Self-Study/assets/48712088/68515b47-f9d4-4383-a883-5007b222baf5)

![junc selfmove testdir after](https://github.com/reruo321/OS-Self-Study/assets/48712088/4c42358e-0cf3-4c9f-a2ac-3059e67ac63d)

When you create a new file, "456.txt" in "mydir", both "mydir" and "junc" in "testdir" have "456.txt". However, no change on the junction in the "Desktop".

![mydir selfmove final](https://github.com/reruo321/OS-Self-Study/assets/48712088/76e7687f-821e-4037-97e5-704afe855b6f)

![junc selfmove final](https://github.com/reruo321/OS-Self-Study/assets/48712088/e268d15c-c70c-4723-9c13-86ef0cfbde03)

When you move the junction from the "Desktop" to "testdir", "mydir" has "123.txt" and "456.txt"! Moreover, the junction also have both of the files. It seems as if the junctions are merged without any message.

</details>

#### 3-a. Symbolic Link - File

<details><summary>SPOILERS</summary>

Executing the link opens its target, "myfile.txt".



After moving its target "myfile.txt", the new target became "hardlink.txt".



After deleting its target "myfile.txt", the new target became "hardlink.txt".



Even if "myfile.txt" is created again, the link still points to "hardlink.txt".



Although the link is moved, it still points to "myfile.txt".

</details>

#### 3-b. Symbolic Link - Directory

<details><summary>SPOILERS</summary>

Executing the link opens its target, "myfile.txt".



After moving its target "myfile.txt", the new target became "hardlink.txt".



After deleting its target "myfile.txt", the new target became "hardlink.txt".



Even if "myfile.txt" is created again, the link still points to "hardlink.txt".



Although the link is moved, it still points to "myfile.txt".

</details>

#### 4. Hard Link

<details><summary>SPOILERS</summary>

Executing the link opens its target, "myfile.txt".



After moving its target "myfile.txt", the new target became "hardlink.txt".



After deleting its target "myfile.txt", the new target became "hardlink.txt".



Even if "myfile.txt" is created again, the link still points to "hardlink.txt".



Although the link is moved, it still points to "myfile.txt".

</details>
