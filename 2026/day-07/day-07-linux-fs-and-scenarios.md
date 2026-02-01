# Day 07 – Linux File System Hierarchy & Scenario-Based Practice

---

## Part 1: Linux File System Hierarchy**** 

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

### Hands-on Tasks: 

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

## Part 2: Scenario-Based Practice****

### Scenario 1: Service Not Starting

#### ** Problem: A web application service called myapp failed to start after reboot. **

Step 1:
```bash
systemctl status myapp
```
Why: Checks whether the service is running, failed, or inactive.
Step 2:
```bash
journalctl -u myapp -n 50
```
Why: Shows recent logs to understand why the service failed.
Step 3:
```bash 
systemctl is-enabled myapp
```
Why: Checks if the service is configured to start automatically on boot.
Step 4:
```bash
systemctl list-units --type=service
```
Why: Verifies whether the service exists and is recognized by systemd.

** What I learned: Always check service status first, then logs, then boot configuration. **

### Scenario 2: High CPU Usage

#### ** Problem: Application server is slow due to high CPU usage. **

Step 1:
```bash
top
```
Why: Shows live CPU usage and highlights processes consuming the most CPU.
Step 2:
```bash
ps aux --sort=-%cpu | head -10
```
Why: Lists top CPU-consuming processes in sorted order.
Step 3:
```bash
ps -p <PID> -o pid,pcpu,pmem,cmd
```
Why: Inspects the specific process causing high CPU usage.

** What I learned: Identify the process first before restarting or killing anything. **

### Scenario 3: Finding Service Logs

#### ** Problem: Developer asks where logs for the docker service are located. **

Step 1:
```bash
systemctl status docker
```
Why: Confirms Docker service status and verifies it is systemd-managed.
Step 2:
```bash
journalctl -u docker -n 50
```

Why: Views recent Docker logs stored in journald.
Step 3:
```bash
journalctl -u docker -f
```
Why: Follows Docker logs in real time for live debugging.

** What I learned: systemd services log to journald by default. **

### Scenario 4: File Permissions Issue

#### ** Problem: Script /home/user/backup.sh fails with “Permission denied”.**

Step 1:
```bash
ls -l /home/user/backup.sh
```
Why: Checks file permissions and confirms execute permission is missing.
Step 2:
```bash
chmod +x /home/user/backup.sh
```
Why: Adds execute permission to the script.
Step 3:
```bash
ls -l /home/user/backup.sh
```
Why: Verifies that execute permission was successfully added.
Step 4:
```bash
./backup.sh
```
Why: Confirms the script now runs correctly.

** What I learned: A script must have execute (x) permission to run. **


