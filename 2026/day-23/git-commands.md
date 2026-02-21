## Branch Management
| Command | Purpose | Example |
|---------|---------|---------|
| `git branch` | List branches | `git branch` |
| `git branch <name>` | Create branch | `git branch feature` |
| `git switch <name>` | Switch branch | `git switch main` |
| `git switch -c <name>` | Create+switch | `git switch -c hotfix` |
| `git branch -d <name>` | Delete merged | `git branch -d feature` |
| `git branch -D <name>` | Force delete | `git branch -D broken` |


# Git Commands Cheat Sheet

## Basic Commands
git clone <repo>
git add .
git commit -m "message"

## Branching
git branch
git checkout -b feature

## Advanced Commands
git stash
git stash pop
git rebase
git cherry-pick <commit-id>
git reset --hard HEAD~1