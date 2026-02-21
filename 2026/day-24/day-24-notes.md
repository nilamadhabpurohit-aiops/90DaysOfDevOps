# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Task 1: Git Merge — Observations

### What is a Fast-forward merge?

A fast-forward merge happens when the main branch has no new commits and Git simply moves the branch pointer forward to the feature branch. No new merge commit is created.

### When does Git create a merge commit?

Git creates a merge commit when both branches have new commits. This happens when the main branch has progressed after the feature branch was created.

### What is a merge conflict?

A merge conflict occurs when the same line in the same file is modified in two different branches. Git cannot decide which change to keep automatically, so the developer must resolve it manually.

### My Observation:

When I merged `feature-login` into `main` without any changes in `main`, Git performed a fast-forward merge. Later, when I added commits to `main` and merged `feature-signup`, Git created a merge commit.

---

## Task 2: Git Rebase — Observations

### What does rebase actually do?

Rebase moves or "replays" the commits from one branch on top of another branch, creating a linear history.

### How is history different from merge?

Merge preserves the branch structure and creates merge commits. Rebase rewrites history to make it look like the work was done sequentially.

### Why should you never rebase shared commits?

Rebasing changes commit hashes. If the commits are already pushed and shared, it can cause conflicts and confusion for other team members.

### When to use rebase vs merge?

Use rebase for local cleanup and maintaining a clean history. Use merge when working in shared branches to preserve history.

### My Observation:

After rebasing `feature-dashboard` onto `main`, the commit history looked linear and cleaner compared to merge.

---

## Task 3: Squash Commit vs Merge Commit

### What does squash merging do?

Squash merge combines multiple commits into a single commit before merging.

### When to use squash merge?

When the feature branch has many small or messy commits that are not meaningful individually.

### Trade-offs of squashing?

It keeps history clean but loses detailed commit history.

### My Observation:

After squash merging `feature-profile`, only one commit was added to `main`. In regular merge, all commits were preserved.

---

## Task 4: Git Stash — Observations

### Difference between `git stash pop` and `git stash apply`

`pop` applies the stash and removes it from stash list. `apply` applies changes but keeps the stash saved.

### When to use stash?

When switching tasks quickly without committing unfinished work.

### My Observation:

I was able to save work in progress, switch branches, and restore changes later.

---

## Task 5: Cherry Picking

### What does cherry-pick do?

Cherry-pick applies a specific commit from one branch to another.

### When to use cherry-pick?

When a bug fix or important change from one branch is needed in another branch without merging the entire branch.

### What can go wrong?

Conflicts, duplicate commits, and messy history.

### My Observation:

I successfully cherry-picked only the required commit from `feature-hotfix` into `main`.
