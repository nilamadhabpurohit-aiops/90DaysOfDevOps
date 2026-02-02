# Day 10 Challenge

## Task 1: Create Files
```bash
ubuntu@ip-172-31-70-51:~$ ls -l
total 8
-rw-rw-r-- 1 ubuntu ubuntu  0 Feb  2 14:21 devops.txt
-rw-rw-r-- 1 ubuntu ubuntu 21 Feb  2 14:24 notes.txt
-rw-rw-r-- 1 ubuntu ubuntu 20 Feb  2 14:25 script.sh
```

Task 2: Read Files

```bash
ubuntu@ip-172-31-70-51:~$ cat notes.txt
Hello! Howz the Josh
ubuntu@ip-172-31-70-51:~$ vim -R script.sh
ubuntu@ip-172-31-70-51:~$ head -n 5 /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
ubuntu@ip-172-31-70-51:~$ tail -n 5 /etc/passwd
fwupd-refresh:x:990:990:Firmware update daemon:/var/lib/fwupd:/usr/sbin/nologin
polkitd:x:989:989:User for polkitd:/:/usr/sbin/nologin
ec2-instance-connect:x:109:65534::/nonexistent:/usr/sbin/nologin
_chrony:x:110:112:Chrony daemon,,,:/var/lib/chrony:/usr/sbin/nologin
ubuntu:x:1000:1000:Ubuntu:/home/ubuntu:/bin/bash
```

## Task 3: Understand Permissions

Format: rwxrwxrwx (owner-group-others)
r = read (4), w = write (2), x = execute (1)
Check your files: ls -l devops.txt notes.txt script.sh

```bash
ubuntu@ip-172-31-70-51:~$ ls -l
total 8
-rw-rw-r-- 1 ubuntu ubuntu  0 Feb  2 14:21 devops.txt
-rw-rw-r-- 1 ubuntu ubuntu 21 Feb  2 14:24 notes.txt
-rw-rw-r-- 1 ubuntu ubuntu 20 Feb  2 14:25 script.sh
```
Observation:
- devops.txt → owner can read/write
- notes.txt → owner can read/write
- script.sh → not executable (no x)

## Task 4: Modify Permissions
1. Make script.sh executable → run it with ./script.sh
2. Set devops.txt to read-only (remove write for all)
3. Set notes.txt to 640 (owner: rw, group: r, others: none)
4. Create directory project/ with permissions 755

```bash
ubuntu@ip-172-31-70-51:~$ chmod +x script.sh
ubuntu@ip-172-31-70-51:~$ sh script.sh
Hello DevOps
ubuntu@ip-172-31-70-51:~$ chmod a-w devops.txt
ubuntu@ip-172-31-70-51:~$ ls -l devops.txt
-r--r--r-- 1 ubuntu ubuntu 0 Feb  2 14:21 devops.txt
ubuntu@ip-172-31-70-51:~$ chmod 640 notes.txt
ubuntu@ip-172-31-70-51:~$ ls -l notes.txt
-rw-r----- 1 ubuntu ubuntu 21 Feb  2 14:24 notes.txt
ubuntu@ip-172-31-70-51:~$ mkdir project
ubuntu@ip-172-31-70-51:~$ chmod 755 project/
ubuntu@ip-172-31-70-51:~$ ls -ld project/
drwxr-xr-x 2 ubuntu ubuntu 4096 Feb  2 14:33 project/
```

## Task 5: Test Permissions
1. Try writing to a read-only file - what happens?
2. Try executing a file without execute permission
3. Document the error messages
```bash
ubuntu@ip-172-31-70-51:~$ echo "test" >> devops.txt
-bash: devops.txt: Permission denied
ubuntu@ip-172-31-70-51:~$ ./script.sh
Hello DevOps
ubuntu@ip-172-31-70-51:~$ chmod a-x script.sh
ubuntu@ip-172-31-70-51:~$ ./script.sh
-bash: ./script.sh: Permission denied
```
## Commands Used
- touch
- echo
- cat
- vim
- head
- tail
- chmod
- ls -l

## What I Learned
- How Linux file permissions work (r, w, x)
- Difference between read, write, and execute permissions
- Why execute permission is required to run scripts
