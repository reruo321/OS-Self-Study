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

![shortf move before pro](https://github.com/reruo321/OS-Self-Study/assets/48712088/eb10653c-8798-405a-b7c8-72c8aef6491d)

Executing the shortcut opens its target, "myfile.txt". We can check the target from "Properties" of the shortcut.

![shortf move](https://github.com/reruo321/OS-Self-Study/assets/48712088/316ca9b9-b0fb-46e8-b324-4bea32f948a4)

![shortf move after pro](https://github.com/reruo321/OS-Self-Study/assets/48712088/3bbf0220-f5ea-4283-9ea2-d098a2a9da71)

After moving its target "myfile.txt", nothing happens. However, if you execute the shortcut, the new target becomes "hardlink.txt"!

![shortf move](https://github.com/reruo321/OS-Self-Study/assets/48712088/bc92fb50-0eae-4a5f-ad17-ecd8e525c420)

![shortf move after pro](https://github.com/reruo321/OS-Self-Study/assets/48712088/5478ef4d-a4cd-42bf-adcb-e121cabfae3e)

After deleting its target "myfile.txt", nothing happens. However, if you execute the shortcut, the new target becomes "hardlink.txt"!

![shortf after](https://github.com/reruo321/OS-Self-Study/assets/48712088/e79f28b7-9fb8-442b-a680-a9f7608b9ef8)

Even if "myfile.txt" is created again, the shortcut still points to "hardlink.txt"!

![shortf selfmove](https://github.com/reruo321/OS-Self-Study/assets/48712088/90a8085a-0c24-4fbf-ac1a-ac53f7b34287)

Although the shortcut is moved, it still points to "myfile.txt".

#### Results without Hard Link
![shortf move no hardlink](https://github.com/reruo321/OS-Self-Study/assets/48712088/249247d6-51b4-474d-b753-a8d1fffb52db)

If there is no hard link of "myfile.txt", the shortcut will open its target in almost situations.

When its target is moved to the "Recycle Bin", an error message will pop up, and it will ask whether you recover the target, or delete the shortcut. When its target is completely deleted, another error message will pop up, and it will ask whether you delete the shortcut or not.

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

![symf see](https://github.com/reruo321/OS-Self-Study/assets/48712088/96a7ad22-d294-4cdb-ad3b-a01047145c2f)

Executing the symbolic link opens its target, "myfile.txt".

![symf move](https://github.com/reruo321/OS-Self-Study/assets/48712088/96109449-54e5-47db-ac0d-8fcc4aa072ce)

After moving its target "myfile.txt", the symbolic link does not work at all.

![symf move](https://github.com/reruo321/OS-Self-Study/assets/48712088/3521405b-76ad-4251-9078-64dd9caa1d7d)

After deleting its target "myfile.txt", the symbolic link does not work at all.

![symf after](https://github.com/reruo321/OS-Self-Study/assets/48712088/87795b11-065c-4138-9dcd-424dc0112bf4)

When "myfile.txt" is created again, the symbolic link points to it.

![symf selfmove](https://github.com/reruo321/OS-Self-Study/assets/48712088/d5e1dc3a-2ec2-49fa-923a-b15d09b096f4)

If the symbolic link is moved, it does not work at all.

</details>

#### 3-b. Symbolic Link - Directory

<details><summary>SPOILERS</summary>

![symd see](https://github.com/reruo321/OS-Self-Study/assets/48712088/44406dff-d32f-4008-897a-f4849be0dc36)

Executing the symbolic link opens "symlink_dir". Except the directory, it looks the same as "mydir".

![symd move](https://github.com/reruo321/OS-Self-Study/assets/48712088/0a7de156-c4fc-40ab-ac9e-7530d5589d2b)

After moving its target "mydir", the symbolic link becomes unavailable and an error message pops up.

![symd move](https://github.com/reruo321/OS-Self-Study/assets/48712088/00149e2b-bddd-4f0f-8e78-23c8cc536efe)

After deleting its target "mydir", the symbolic link becomes unavailable and an error message pops up.

![symd see](https://github.com/reruo321/OS-Self-Study/assets/48712088/88b3a7bf-c62b-456f-a055-1d104c53a873)

When "myfile.txt" is created again, the symbolic link points to it.

![symd selfmove](https://github.com/reruo321/OS-Self-Study/assets/48712088/a3998d17-d83c-490e-be7a-b3b3c5d62c9a)

If the symbolic link is moved, it becomes unavailable and an error message pops up.

</details>

#### 4. Hard Link

<details><summary>SPOILERS</summary>

※ When the hard link and its target shares the contents, it means that modifying either of them affects both of them!

![hard see](https://github.com/reruo321/OS-Self-Study/assets/48712088/4351bfef-c20c-4cf8-b4dc-08280f821cac)

Executing the hard link opens "hardlink.txt". It shares the contents with "myfile.txt".

![hard move](https://github.com/reruo321/OS-Self-Study/assets/48712088/311cc143-514f-409e-bcec-501686209eb9)

Even if moving "myfile.txt", the hard link still opens "hardlink.txt", sharing the contents with "myfile.txt".

![hard move](https://github.com/reruo321/OS-Self-Study/assets/48712088/22366fbe-6f6d-44d6-8c74-fe38fbe5349f)

Even if you put "myfile.txt" into the "Recycle Bin", the hard link still opens "hardlink.txt", keeping its contents. It also shares the contents with "myfile.txt". Therefore, if you modify "hardlink.txt" and then recover "myfile.txt", you can see their contents are the same!

Otherwise, completely deleting "myfile.txt" disconnects the contents sharing of "hardlink.txt". It keeps its contents anyway.

![hard after](https://github.com/reruo321/OS-Self-Study/assets/48712088/a4a53403-30c9-44b3-9682-f99091b3bd4c)

Even if you create "myfile.txt" again, the hard link still opens "hardlink.txt". However, it does not share its contents with the new "myfile" anymore!

![hard selfmove](https://github.com/reruo321/OS-Self-Study/assets/48712088/6fd343d1-ceb9-455f-b800-d7c18caaf5ed)

Even if the hard link is moved, it still opens "hardlink.txt", sharing the contents with "myfile.txt".

</details>
