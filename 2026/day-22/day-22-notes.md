# Day 22 – Introduction to Git

Today I started my journey with Git and understood the basics of version control and how it is used in DevOps workflows.

---

## Task 1: Install and Configure Git

### Verified Git installation
I checked whether Git was installed using:

git --version

Git was successfully installed on my system.

---

### Configured Git identity

I configured my name and email so that my commits are properly tracked:

git config --global user.name "Nilamadhab Purohit"
git config --global user.email "nilamadhabpurohit@outlook.com"

---

### Verified configuration

git config --list

This confirmed that my name and email were correctly configured.

---

---

## Task 2: Created My Git Project

### Created a new folder
I created a folder to practice Git:

mkdir devops-git-practice
cd devops-git-practice

---

### Initialized the repository

git init

This created a new Git repository.

---

### Checked Git status

git status

This showed:
- No commits yet
- No files tracked
- Suggested next steps

I understood that Git helps track changes in files.

---

### Explored the `.git` folder

I checked the hidden Git directory:

ls -la

The `.git/` folder contains:
- Commit history
- Configuration
- Branch information
- Staging area
- Object database

This is the core of Git.

---

---

## Task 3: Created Git Commands Reference

I created a file called:

git-commands.md

This file will act as my personal Git cheat sheet.

I added commands under categories:
- Setup & Config
- Basic Workflow
- Viewing Changes

Each command includes:
- What it does
- Example usage

This will be updated daily.

---

---

## Task 4: Staging and Committing

### Staged the file

git add git-commands.md

This added the file to the staging area.

---

### Checked staged files

git status

I verified the file was staged.

---

### Created my first commit

git commit -m "Initial commit: added Git commands reference"

---

### Viewed commit history

git log

This showed:
- Commit ID
- Author
- Date
- Commit message

---

---

## Task 5: Built Commit History

I updated the `git-commands.md` multiple times by adding new commands.

After each change:
1. Checked the status
2. Staged the file
3. Committed with meaningful messages

This helped me understand how Git tracks file history.

---

### Viewed compact history

git log --oneline

This showed a clean and short commit history.

---

---

## Task 6: Understanding Git Workflow

### 1. Difference between `git add` and `git commit`

`git add` moves changes from the working directory to the staging area.

`git commit` saves the staged changes permanently in the repository with a message.

---

### 2. What does the staging area do?

The staging area allows us to:
- Select specific changes
- Review before committing
- Organize commits logically

This prevents committing unwanted changes.

---

### 3. What does `git log` show?

It shows:
- Commit history
- Author
- Date and time
- Commit message
- Commit ID

It helps track project evolution.

---

### 4. What is the `.git` folder?

The `.git` folder is the core of the repository. It stores:
- History
- Branches
- Commits
- Configuration

If this folder is deleted, Git tracking is lost and the folder becomes a normal project.

---

### 5. Difference between working directory, staging area, and repository

Working directory:
The current files and changes.

Staging area:
Temporary area where changes are prepared for commit.

Repository:
The permanent storage of all commits and history.

---

---

## Key Learnings

- Git is essential for DevOps and collaboration.
- Version control helps track changes and avoid mistakes.
- Commit history is important for debugging and audits.
- A clean Git workflow improves teamwork.
