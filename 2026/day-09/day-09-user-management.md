# Day 09 Challenge

## Users & Groups Created
- Users: tokyo, berlin, professor, nairobi
- Groups: developers, admins, project-team

## Group Assignments
```bash
cat /etc/group
tokyo:x:1001:
berlin:x:1002:
proffessor:x:1003:
developers:x:1004:tokyo,berlin
admins:x:1005:berlin
nairobi:x:1006:
project-team:x:1007:tokyo,nairobi

```
Observation:
User - Group 
- tokyo: developers. project-team
- berlin: developers, admins
- professor: admins
- nairobi: project-team


## Directories Created
```bash
ubuntu@ip-172-31-24-106:~$ ls -l /opt/
total 8
drwxrwxr-x 2 root developers   4096 Feb  1 14:50 dev-project
drwxrwxr-x 2 root project-team 4096 Feb  1 15:05 team-workspace
```

## Commands Used
- useradd: Creates a new user account on the system
- passwd: Sets or changes a user’s password
- groupadd: Creates a new group
- usermod: Modifies an existing user (add to groups, change settings)
- groups: Shows which groups a user belongs to
- chgrp: Changes the group ownership of a file or directory
- chmod: Changes file or directory permissions
- ls -l: Lists files with detailed permissions and ownership info

## What I Learned
- How to manage users and groups in Linux
- How group permissions enable team collaboration
- How shared directories are set up in real systems

### Note :
Troubleshooting
- Permission denied? Use sudo
- User can't access directory?
- Check group: groups username
- Check permissions: ls -ld /path
