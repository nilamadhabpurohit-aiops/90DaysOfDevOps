# Git Commands Reference (Intermediate Level)

This file is my growing Git reference as I continue building my DevOps skills.

---

## 🔹 Setup & Config

### Configure global user identity
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### View all Git configuration
```bash
git config --list
```

### Check Git version
```bash
git --version
```

---

## 🔹 Repository Setup

### Initialize a repository
```bash
git init
```

### View the `.git` structure
```bash
ls -a .git
```

---

## 🔹 Basic Workflow

### Check repository status
```bash
git status
```

### Add changes to staging
```bash
git add <file>
git add .              # add all changes
```

### Commit changes
```bash
git commit -m "Meaningful message"
```

### Remove a file from staging
```bash
git reset <file>
```

---

## 🔹 Viewing Changes

### Unstaged changes
```bash
git diff
```

### Staged changes
```bash
git diff --cached
```

### Full commit history
```bash
git log
```

### Compact, one‑line history
```bash
git log --oneline
```

---

## 🔹 Helpful Utilities

### Show detailed commit
```bash
git show <commit-id>
```

### See which branch you are on
```bash
git branch
```

---

*I will continue expanding this reference as I learn branching, merging, rebasing, and collaboration workflows.*
