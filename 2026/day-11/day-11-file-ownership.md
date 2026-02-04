# Day 11 – File Ownership Challenge (chown & chgrp)

---

## Task 1: Understanding Ownership

### Command
```bash
ubuntu@ip-172-31-70-51:~$ ls -l
total 12
-r--r--r-- 1 ubuntu ubuntu    0 Feb  2 14:21 devops.txt
-rw-r----- 1 ubuntu ubuntu   21 Feb  2 14:24 notes.txt
drwxr-xr-x 2 ubuntu ubuntu 4096 Feb  2 14:33 project
-rw-rw-r-- 1 ubuntu ubuntu   20 Feb  2 14:25 script.sh
```
Observation: Each file shows owner and group
Difference between Owner and Group:
- Owner: Primary user who owns the file
- Group: Group users who share specific permissions on the file

## Task 2: Basic chown Operations

```bash
ubuntu@ip-172-31-70-51:~$ touch devops-file.txt
ubuntu@ip-172-31-70-51:~$ ls -l
total 12
-rw-rw-r-- 1 ubuntu ubuntu    0 Feb  4 18:12 devops-file.txt
ubuntu@ip-172-31-70-51:~$ sudo chown tokyo devops-file.txt
chown: invalid user: ‘tokyo’
ubuntu@ip-172-31-70-51:~$ sudo useradd -m tokyo
ubuntu@ip-172-31-70-51:~$ sudo passwd tokyo
New password:
Retype new password:
passwd: password updated successfully
ubuntu@ip-172-31-70-51:~$ sudo chown tokyo devops-file.txt
ubuntu@ip-172-31-70-51:~$ ls -l
total 12
-rw-rw-r-- 1 tokyo  ubuntu    0 Feb  4 18:12 devops-file.txt
-r--r--r-- 1 ubuntu ubuntu    0 Feb  2 14:21 devops.txt
-rw-r----- 1 ubuntu ubuntu   21 Feb  2 14:24 notes.txt
drwxr-xr-x 2 ubuntu ubuntu 4096 Feb  2 14:33 project
-rw-rw-r-- 1 ubuntu ubuntu   20 Feb  2 14:25 script.sh
ubuntu@ip-172-31-70-51:~$ sudo chown berlin devops-file.txt
chown: invalid user: ‘berlin’
ubuntu@ip-172-31-70-51:~$ sudo useradd -m berlin
ubuntu@ip-172-31-70-51:~$ sudo passwd berlin
New password:
Retype new password:
passwd: password updated successfully
ubuntu@ip-172-31-70-51:~$ sudo chown berlin devops-file.txt
ubuntu@ip-172-31-70-51:~$ ls -l
total 12
-rw-rw-r-- 1 berlin ubuntu    0 Feb  4 18:12 devops-file.txt
-r--r--r-- 1 ubuntu ubuntu    0 Feb  2 14:21 devops.txt
-rw-r----- 1 ubuntu ubuntu   21 Feb  2 14:24 notes.txt
drwxr-xr-x 2 ubuntu ubuntu 4096 Feb  2 14:33 project
-rw-rw-r-- 1 ubuntu ubuntu   20 Feb  2 14:25 script.sh
```

## Task 3: Basic chgrp Operations 

```bash
ubuntu@ip-172-31-70-51:~$ touch team-notes.txt
ubuntu@ip-172-31-70-51:~$ ls -l team-notes.txt
-rw-rw-r-- 1 ubuntu ubuntu 0 Feb  4 18:21 team-notes.txt
ubuntu@ip-172-31-70-51:~$ sudo groupadd heist-team
ubuntu@ip-172-31-70-51:~$ sudo chgrp heist-team team-notes.txt
ubuntu@ip-172-31-70-51:~$ ls -l team-notes.txt
-rw-rw-r-- 1 ubuntu heist-team 0 Feb  4 18:21 team-notes.txt
```
Observation: Group ownership updated to heist-team

## Task 4: Combined Owner & Group Change

```bash
ubuntu@ip-172-31-70-51:~$ touch project-config.yaml
ubuntu@ip-172-31-70-51:~$ sudo chown professor:heist-team project-config.yaml
chown: invalid user: ‘professor:heist-team’
ubuntu@ip-172-31-70-51:~$ sudo useradd -m professor
ubuntu@ip-172-31-70-51:~$ sudo chown professor:heist-team project-config.yaml
ubuntu@ip-172-31-70-51:~$ ls -l project-config.yaml
-rw-rw-r-- 1 professor heist-team 0 Feb  4 18:24 project-config.yaml
ubuntu@ip-172-31-70-51:~$ mkdir app-logs
ubuntu@ip-172-31-70-51:~$ sudo chown berlin:heist-team app-logs/
ubuntu@ip-172-31-70-51:~$ ls -ld app-logs
drwxrwxr-x 2 berlin heist-team 4096 Feb  4 18:27 app-logs
```
Observation: Ownership and group changed in one command

## Task 5: Recursive Ownership

```bash
ubuntu@ip-172-31-70-51:~$ sudo chown -R professor:planners heist-project/
ubuntu@ip-172-31-70-51:~$ ls -lR heist-project/
heist-project/:
total 8
drwxrwxr-x 2 professor planners 4096 Feb  4 18:31 plans
drwxrwxr-x 2 professor planners 4096 Feb  4 18:31 vault

heist-project/plans:
total 0
-rw-rw-r-- 1 professor planners 0 Feb  4 18:31 strategy.conf

heist-project/vault:
total 0
-rw-rw-r-- 1 professor planners 0 Feb  4 18:31 gold.txt
```

Observation: Ownership updated for all files and subdirectories

## Task 6: Practice Challenge

```bash
ubuntu@ip-172-31-70-51:~$ sudo useradd -m nairobi
ubuntu@ip-172-31-70-51:~$ sudo groupadd vault-team
ubuntu@ip-172-31-70-51:~$ sudo groupadd tech-team
ubuntu@ip-172-31-70-51:~$ mkdir bank-heist
ubuntu@ip-172-31-70-51:~$ ls
app-logs    devops-file.txt  heist-project  project              script.sh
bank-heist  devops.txt       notes.txt      project-config.yaml  team-notes.txt
ubuntu@ip-172-31-70-51:~$ touch bank-heist/access-codes.txt
ubuntu@ip-172-31-70-51:~$ touch bank-heist/blueprints.pdf
ubuntu@ip-172-31-70-51:~$ touch bank-heist/escape-plan.txt
ubuntu@ip-172-31-70-51:~$ sudo chown tokyo:vault-team bank-heist/access-codes.txt
ubuntu@ip-172-31-70-51:~$ sudo chown berlin:tech-team bank-heist/blueprints.pdf
ubuntu@ip-172-31-70-51:~$ sudo chown nairobi:vault-team bank-heist/escape-plan.txt
ubuntu@ip-172-31-70-51:~$ ls -l bank-heist/
total 0
-rw-rw-r-- 1 tokyo   vault-team 0 Feb  4 18:34 access-codes.txt
-rw-rw-r-- 1 berlin  tech-team  0 Feb  4 18:34 blueprints.pdf
-rw-rw-r-- 1 nairobi vault-team 0 Feb  4 18:34 escape-plan.txt
```

Observation: Each file has correct owner and group assigned



