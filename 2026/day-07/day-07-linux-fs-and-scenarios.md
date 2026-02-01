# Day 07 – Linux File System Hierarchy & Scenario-Based Practice

---

## Part 1: Linux File System Hierarchy 

The Linux File System Hierarchy is organized under a single root directory /, 
from which all other directories branch. Each directory has a specific role in system operation, user data management, and hardware interaction. 
Below is a detailed account of essential directories:

<img width="656" height="443" alt="image" src="https://github.com/user-attachments/assets/6e633b97-3763-4d94-a87a-72bd115bb9aa" />


### / (root)
- The top-level directory; everything in Linux starts here

Command:
```bash
ls -l /
```
<img width="1067" height="714" alt="image" src="https://github.com/user-attachments/assets/9779fdae-2257-43cc-af3e-81d184c32572" />

Purpose: The top-level directory; serves as the starting point for the entire filesystem. All files and directories originate here.
Role: Provides the foundation and structure of the Linux system.
I would use this when: Exploring the overall system structure

### /home
- Contains home directories for normal users

Command:
```bash
ls -l /home
```

Purpose: Stores personal files and settings for each user. [e.g. /home/john for user john.]
Role: Separates user-specific data from system files; ensures privacy and organization.
I would use this when: Accessing user files, scripts, or configs

### /root
- Home directory of the root (admin) user

Command:
```bash
ls -al /root
```
<img width="721" height="277" alt="image" src="https://github.com/user-attachments/assets/b1f0c008-3ad9-45f2-a569-04b9a733c7a6" />
Purpose: Home directory for the root user, distinct from /home.
Role: Ensures administrative access and data separation from regular users.
I would use this when:: Performing admin or recovery tasks

### /etc
- Stores system-wide configuration files
Command:
```bash
ls -l /etc
```
Purpose: Hosts system-wide configuration files and shell scripts. [e.g. /etc/passwd, /etc/fstab, /etc/hosts.]
Role: Central repository for system and application settings affecting all users.
I would use this when: Editing or troubleshooting configuration issues

### /var/log
- Contains system and application log files

Command:
```bash
ls -l /var/log
```
Purpose: Holds data that changes frequently during normal operation.
Subdirectories:
/var/log – System and application logs.
/var/spool – Queued tasks like mail or print jobs.
/var/cache – Cached data.
/var/lib – Application state data.
/var/tmp – Temporary files that persist across reboots.
Role: Critical for logging, system tracking, and persistent variable data.

Observed: [/var/log] Logs such as syslog, auth.log, journal/
I would use this when: Investigating errors or service failures

### /tmp
- Temporary files used by applications
Command:
```bash
ls -l /tmp
```
Purpose: Stores temporary files created by users and applications.
Role: Data here is transient, usually cleared on reboot; used for short-term storage.

I would use this when: Storing short-lived or test files

### Additional Directories (Good to Know):
#### /bin

Essential command binaries required for system operation

Command:
```bash
ls -l /bin
```
Purpose: /bin contains executable programs essential for normal system operation and booting. 
These commands are available to all users and are critical in single-user mode or during system recovery

I would use this when: Performing basic file operations or repair tasks if other file system (like [/usr])

#### /usr/bin

- User command binaries and installed applications
Command:
```bash
ls -l /usr/bin
```
Purpose: [/usr/bin] contains the majority of system-wide executable programs that are not strictly necessary for booting or recovery. 
These are “user binaries” and serve as the main repository for commands used by everyday users, including tools for file manipulation, text processing, and programming
I would use this when: User command, Script or to run installed applications

#### /opt
- Optional or third-party applications
Command:
```bash
ls -l /opt
```
Purpose: Stores software packages not included with the base system.
Role: Separates third-party applications from core system directories.
I would use this when: Managing custom or vendor software

### Hands-on Tasks
<img width="2132" height="1006" alt="image" src="https://github.com/user-attachments/assets/c185fcc2-5521-4d3e-84a1-f1f2f1de55da" />
```bash
# Find the largest log file in /var/log
du -sh /var/log/* 2>/dev/null | sort -h | tail -5

# Look at a config file in /etc
cat /etc/hostname

# Check your home directory
ls -la ~
```
Observations: 
- Identifies log files consuming the most disk space
- Displays the system hostname
- Shows user files and hidden configuration files.

