# Day 13 – Linux LVM (Logical Volume Manager)

## Objective
Learn to manage storage flexibly using LVM by creating, mounting, and extending logical volumes.


Create Virtual Disk (Practice Disk)
```bash
dd if=/dev/zero of=/tmp/disk1.img bs=1M count=1024
losetup -fP /tmp/disk1.img
losetup -a
```
Output
```bash
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied
/dev/loop3: [66305]:33601 (/tmp/disk1.img)
/dev/loop4: [66305]:33601 (/tmp/disk1.img)
```
Task 1: Check Current Storage State
Commands
```bash
lsblk
pvs
vgs
lvs
df -h
```
Output
````
NAME         SIZE TYPE MOUNTPOINT
loop3          1G loop
loop4          1G loop
nvme0n1        8G disk /
nvme1n1       10G disk
nvme2n1       12G disk
````
pvs → No output
vgs → No output
lvs → No output

Task 2: Create Physical Volume (PV)
Command
```bash
pvcreate /dev/nvme1n1

Output
Physical volume "/dev/nvme1n1" successfully created.
```

Task 3: Create Volume Group (VG)
Command
```bash 
vgcreate devops-vg /dev/nvme1n1

Output
Volume group "devops-vg" successfully created
```
Task 4: Create Logical Volume (LV)
Commands
```bash
lvcreate -L 500M -n app-data devops-vg
lvs

Output
Logical volume "app-data" created.

LV       VG        Attr       LSize
app-data devops-vg -wi-a----- 500.00m
```
Task 5: Format and Mount Logical Volume
Format Logical Volume
```bash 
mkfs.ext4 /dev/devops-vg/app-data

Output
Filesystem UUID: 2191e795-50c0-4e13-8633-c8e030d0e391
Creating journal: done
```
Mount Logical Volume
```bash 
mkdir -p /mnt/app-data
mount /dev/devops-vg/app-data /mnt/app-data
df -h /mnt/app-data

Output
Filesystem                        Size  Used Avail Use%
/dev/mapper/devops--vg-app--data  452M   24K  417M   1%
```

Task 6: Extend the Logical Volume
Extend Logical Volume Size
```bash
lvextend -L +200M /dev/devops-vg/app-data

Output
Size changed from 500.00 MiB to 700.00 MiB
Logical volume successfully resized.
```
Resize Filesystem
```bash
resize2fs /dev/devops-vg/app-data

Output
Filesystem resized successfully

Verify Extended Size
df -h /mnt/app-data

Output
Filesystem                        Size  Used Avail Use%
/dev/mapper/devops--vg-app--data  637M   24K  594M   1%
```
** What I Learned
- LVM lets you increase or reduce disk size while the system is running, without needing to unmount or stop using the filesystem.
- Linux storage works in layers: first you create a physical disk (PV), then group disks together (VG), and finally create usable storage areas (LV).
- Filesystems like ext4 can grow while mounted, and the [resize2fs] command updates the filesystem to use the new space.
