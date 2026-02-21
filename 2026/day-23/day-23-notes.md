# Day 23 – Git Branching & Working with GitHub

---

## Task 1: Understanding Branches

### 1. What is a branch in Git?

A branch in Git is a lightweight pointer to a specific commit. It allows developers to work on new features, bug fixes, or experiments independently without affecting the main codebase.
Each branch has its own commit history, and changes can be merged later into the main branch.

### 2. Why do we use branches instead of committing everything to `main`?

We use branches because:
- To avoid breaking production code
- To allow multiple developers to work in parallel
- To isolate new features and bug fixes
- To test safely before merging
- To maintain a clean and stable main branch

In real DevOps environments, production always runs from a stable branch like `main` or `master`.


### 3. What is `HEAD` in Git?

HEAD is a pointer that refers to the current branch and the latest commit we are working on.
It tells Git:
- Which branch we are currently on
- Which commit our working directory is based on

Example:
If we are on the `feature-1` branch, HEAD points to the latest commit of `feature-1`.


### 4. What happens to your files when you switch branches?

When we switch branches:
- Git updates the working directory to match the selected branch.
- Files and code change based on that branch’s latest commit.
- Any uncommitted changes may be carried over or cause conflicts.

This ensures we see the exact code state of the branch.


## Task 2: Branching Commands — Hands-On

### List all branches
```bash
git branch
git branch feature-1 # Create a new branch called feature-1
git switch feature-1 # Switch to feature-1
git switch -c feature-2 # Create and switch to a branch in one command
```

### Difference between `git switch` and `git checkout`

- `git switch` is a modern and safer command used only for switching branches.
- `git checkout` is older and used for both:
    - Switching branches
    - Restoring files
- Using `git switch` reduces accidental mistakes.

### Make a commit on feature-1
Make a commit on feature-1
```bash
git add .
git commit -m "Added feature-1 changes"
```

Verify commit is not in main
```bash 
git switch main
git log
```
The commit from feature-1 will not be visible.

### Delete a branch
```bash 
git branch -d feature-2
```

## Task 3: Push to GitHub

### Connect local repo to GitHub
```bash
git remote add origin <repo-url>
```

Push main branch
git push -u origin main

Push feature-1 branch
git push -u origin feature-1

### Difference between `origin` and `upstream`

- `origin` refers to your own remote repository.
- `upstream` refers to the original repository from which you forked.

In open-source:
`origin` = your fork
`upstream` = original project

## Task 4: Pull from GitHub
### Pull latest changes
```bash 
git pull origin main
```

### Difference between `git fetch` and `git pull`

- `git fetch` downloads changes from the remote but does not merge them.
- `git pull` downloads and merges changes automatically.

Best practice in production:
Use `git fetch` first, then review changes before merging.


## Task 5: Clone vs Fork
### Difference between `clone` and `fork`

1. `Clone`: Copy a repository to your local machine.

2. `Fork`: Create your own copy of a repository on GitHub.

`Fork` is used mainly in open-source contributions.
When to use clone vs fork?

1.1 Use clone:
- When you have direct access to the repository.

2.1 Use fork:
- When contributing to open-source or external projects.
- How to keep your fork in sync with the original repo?

Steps:
```bash
git remote add upstream <original-repo-url>
git fetch upstream
git merge upstream/main
```
