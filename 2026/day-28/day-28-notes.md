# Day 28 – Revision Day (Self Assessment & Improvement Plan)

Today I reviewed everything I learned from Day 1 to Day 27 and honestly evaluated my strengths and weaknesses. This helped me identify areas that need improvement and build a strong foundation for advanced DevOps topics.

---

## Task 1: Self-Assessment Checklist

#### Linux
- [Done] Navigate the file system, create/move/delete files and directories
- [Done] Manage processes — list, kill, background/foreground
- [Done] Work with systemd — start, stop, enable, check status of services
- [Done] Read and edit text files using vi/vim or nano
- [Done] Troubleshoot CPU, memory, and disk issues using top, free, df, du
- [Done] Explain the Linux file system hierarchy (/, /etc, /var, /home, /tmp, etc.)
- [Done] Create users and groups, manage passwords
- [Done] Set file permissions using chmod (numeric and symbolic)
- [Done] Change file ownership with chown and chgrp
- [Done] Create and manage LVM volumes
- [Done] Check network connectivity — ping, curl, netstat, ss, dig, nslookup
- [Revise] Explain DNS resolution, IP addressing, subnets, and common ports

#### Shell Scripting
- [Done] Write a script with variables, arguments, and user input
- [Done] Use if/elif/else and case statements
- [Done] Write for, while, and until loops
- [Revise] Define and call functions with arguments and return values
- [Done] Use grep, awk, sed, sort, uniq for text processing
- [Revise] Handle errors with set -e, set -u, set -o pipefail, trap
- [Done] Schedule scripts with crontab

#### Git & GitHub
- [Done] Initialize a repo, stage, commit, and view history
- [Done] Create and switch branches
- [Done] Push to and pull from GitHub
- [Done] Explain clone vs fork
- [Done] Merge branches — understand fast-forward vs merge commit
- [Revise] Rebase a branch and explain when to use it vs merge
- [Revise] Use git stash and git stash pop
- [Revise] Cherry-pick a commit from another branch
- [Revise] Explain squash merge vs regular merge
- [Revise] Use git reset (soft, mixed, hard) and git revert
- [Done] Explain GitFlow, GitHub Flow, and Trunk-Based Development
- [Revise] Use GitHub CLI to create repos, PRs, and issues

---

---

## Task 2: Topics I Revisited

### 1. DNS, IP Addressing and Subnets

I revised:
- DNS resolution process:
  1. Browser cache
  2. OS resolver
  3. Recursive DNS
  4. Root → TLD → Authoritative DNS
  5. IP returned

- CIDR and subnet basics.
- Public vs private IP.
- Network and broadcast address.

Common ports:
- 22 → SSH
- 80 → HTTP
- 443 → HTTPS
- 3306 → MySQL
- 5432 → PostgreSQL

Key learning:
Most production incidents involve networking or DNS.

---

### 2. Shell Functions and Error Handling

Functions example:

```bash
greet() {
  echo "Hello $1"
}

greet Nilamadhab
```
**Key points:**
- Functions improve reusability.
- Arguments are passed as $1, $2.

**Error Handling**

**I revised:**

- set -e → exit if command fails
- set -u → fail on undefined variables
- set -o pipefail → detect pipe failures
- trap → cleanup or logging on failure.

**Example:**
```bash
set -euo pipefail
trap "echo Error occurred" ERR
```

**Key learning:**
Proper error handling is critical for automation and CI/CD.

## Task 3: Quick-Fire Questions

1. **chmod 755 script.sh**
Owner: read, write, execute.
Group and others: read and execute.

2. **Process vs service**
A process is a running program.
A service runs in background and is managed by systemd.

3. **Process using port 8080**
ss -tulnp | grep 8080

4. **set -euo pipefail**
Stops script on errors and catches pipe failures.

5. **git reset vs git revert**
Reset removes history.
Revert creates new commit.

6. **Branching strategy for small team**
GitHub Flow.

7. **git stash**
Temporarily saves changes.

8. **Schedule script at 3 AM**
0 3 * * * /path/script.sh

9. **git fetch vs pull**
Fetch downloads.
Pull downloads and merges.

10. **LVM**
Flexible and resizable storage.

## Task 4: Organization Check
- Verified all tasks are committed and pushed.
- Updated git-commands.md.
- Reviewed shell scripting cheat sheet.
- Cleaned GitHub repositories.

## Task 5: Teach It Back
#### Explaining File Permissions
File permissions control who can read, write, and execute files in Linux.
Each file has three types of users:

Owner
Group
Others

Permissions are represented using numbers:
7 = read, write, execute
5 = read and execute

This helps protect systems and maintain security.