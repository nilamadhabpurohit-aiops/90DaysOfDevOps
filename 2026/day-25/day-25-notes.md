# Day 25 – Git Reset vs Revert & Branching Strategies

## Task 1: Git Reset — Hands-On

### Step 1: Created 3 commits (A, B, C)
I created three commits in my practice repository to understand how Git reset works.

Commit history:
A → B → C

---

### Step 2: git reset --soft HEAD~1

After running:
git reset --soft HEAD~1

#### Observation:
- HEAD moved back to commit B.
- Changes from commit C were **kept in the staging area**.
- I was able to recommit the same changes immediately.

**Conclusion:**  
Soft reset removes the last commit but keeps all changes staged.

---

### Step 3: git reset --mixed HEAD~1

After recommitting C and running:
git reset --mixed HEAD~1

#### Observation:
- HEAD moved back to commit B.
- Changes from commit C were **unstaged but still present in the working directory**.
- I needed to run `git add` again before committing.

**Conclusion:**  
Mixed reset removes the commit and unstages the changes.

Note: This is the default reset mode.

---

### Step 4: git reset --hard HEAD~1

After recommitting and running:
git reset --hard HEAD~1

#### Observation:
- HEAD moved back to commit B.
- Changes from commit C were completely deleted.
- Both staging and working directory were cleaned.

**Conclusion:**
Hard reset permanently deletes changes.

---

### Difference between --soft, --mixed, and --hard

| Reset Type | HEAD | Staging Area | Working Directory |
|------------|------|--------------|------------------|
| Soft | Moves | Keeps changes | Keeps changes |
| Mixed | Moves | Removes staging | Keeps changes |
| Hard | Moves | Removes | Removes |

---

### Which one is destructive and why?

- `git reset --hard` is destructive because it permanently deletes local changes from the working directory and staging area.  
These changes cannot be recovered easily unless using `git reflog`.

---

### When to use each?

**Soft reset:**
- Fix commit messages  
- Combine commits  

**Mixed reset:**
- Modify changes before recommitting  
- Remove incorrect staging  

**Hard reset:**
- Delete unwanted local work  
- Clean local environment  

---

### Should you use git reset on pushed commits?

**No.**  
- Because it rewrites commit history and may create conflicts for other developers.

- It should only be used for local commits.

---

---

## Task 2: Git Revert — Hands-On

### Step 1: Created 3 commits (X, Y, Z)

Commit history:
X → Y → Z

---

### Step 2: Reverted commit Y

After running:
git revert <commit-id-of-Y>

#### Observation:
- Git created a new commit that reversed the changes of commit Y.
- No commit was deleted.

New history:
X → Y → Z → Revert(Y)

---

### Step 3: Checked git log

Yes, commit Y was still present in the commit history.

**Conclusion:**
Revert does not remove commits. It only creates a new commit that undoes the changes.

---

### How is git revert different from git reset?

- `git reset` removes commits and rewrites history.
- `git revert` keeps history intact and adds a new commit.

---

### Why is revert considered safer?

**Because:**
- It does not change commit history.
- It is safe for shared and remote branches.
- Other developers will not face conflicts.

---

### When would you use revert vs reset?

**Use git revert when:**
- The commit is already pushed.
- Working in a team.
- Fixing production issues.

**Use git reset when:**
- Fixing local mistakes.
- Cleaning local commit history.
- Before pushing to remote.

---

### Important Safety Tip

`git reflog` can help recover lost commits even after a hard reset.


## Task 3: Reset vs Revert — Summary

Git provides two main ways to undo changes: **git reset** and **git revert**.  
Both are used to fix mistakes, but they work in different ways and are used in different situations.

---

### Comparison Table

| | `git reset` | `git revert` |
|---|---|---|
| **What it does** | Moves the HEAD pointer to a previous commit and removes commits from history | Creates a new commit that reverses the changes of a specific commit |
| **Removes commit from history?** | Yes | No |
| **Safe for shared/pushed branches?** | No | Yes |
| **When to use** | For local changes and mistakes before pushing | For undoing changes in shared or production branches |

---

### Explanation

#### `git reset`
- Used to undo local commits.
- It changes Git history by removing commits.
- It can be **soft, mixed, or hard** depending on how changes are handled.
- Best used before pushing changes to remote.

Example:
```bash
git reset --soft HEAD~1
```



### Task 4: Branching Strategies

---

#### 1. GitFlow

#### How it works
GitFlow is a structured branching strategy that uses multiple long-lived branches such as:
- `main` (production-ready code)
- `develop` (active development)
- `feature` branches (new features)
- `release` branches (testing before production)
- `hotfix` branches (urgent production fixes)

Developers create feature branches from `develop`, and after testing, code is merged back. Releases and hotfixes follow separate flows.

---

#### Simple flow (diagram)

main → production  
develop → development  
feature → new feature  
release → testing  
hotfix → emergency fix  

---

#### When / Where used
- Large organizations  
- Enterprise applications  
- Teams with scheduled releases  
- Banking, telecom, or regulated environments  

---

#### Pros
- Well-structured workflow  
- Stable and controlled releases  
- Good for large teams  

---

#### Cons
- Complex for beginners  
- Slower delivery  
- More branch management  

---

---

#### 2. GitHub Flow

#### How it works
GitHub Flow is a simple and lightweight strategy. It has:
- One main branch (`main`)
- Short-lived feature branches
- Pull requests for review and merge
- Continuous integration and deployment

Developers create a feature branch from main, test it, open a PR, and merge after approval.

---

#### Simple flow

main → feature → pull request → review → merge → deploy  

---

#### When / Where used
- Startups  
- Agile teams  
- Continuous deployment environments  
- Cloud-native and DevOps teams  

---

#### Pros
- Simple and fast  
- Encourages collaboration  
- Supports CI/CD  

---

#### Cons
- Less control for large teams  
- Risky if testing is weak  

---

---

#### 3. Trunk-Based Development

#### How it works
In this strategy, developers commit directly to the main branch (trunk).  
Feature branches are short-lived and merged quickly.  
Code is integrated multiple times a day.

It requires:
- Automated testing  
- Feature flags  
- Strong CI/CD  

---

#### Simple flow

main ← short-lived feature branches ← merge quickly  

---

####  When / Where used
- High-performing DevOps teams  
- Companies like Google, Netflix  
- Continuous delivery environments  

---

#### Pros
✔ Fast integration  
✔ Fewer merge conflicts  
✔ Faster deployments  

---

#### Cons
- Requires strong automation  
- Needs mature engineering culture  

---

---

#### Answers to Questions

#### Which strategy for a startup shipping fast?
- GitHub Flow, because it is simple, fast, and supports continuous delivery.

---

#### Which strategy for a large team with scheduled releases?
- GitFlow, because it provides better structure and release management.

---

#### Which one does your favorite open-source project use?
 Kubernetes uses a mix of Trunk-Based Development and GitHub Flow:
- Main branch for development  
- Release branches for stable versions  

---

---

## Task 5: Git Commands Reference Update

---

#### Setup & Config
git config --global user.name "Your Name"  
git config --global user.email "your@email.com"  
git init  

---

#### Basic Workflow
git status  
git add .  
git commit -m "message"  
git log  
git diff  

---

#### Branching
git branch  
git checkout -b feature  
git switch branch-name  

---

#### Remote
git clone <repo>  
git remote -v  
git push  
git pull  
git fetch  

---

#### Merging & Rebasing
git merge branch-name  
git rebase branch-name  

---

#### Stash & Cherry Pick
git stash  
git stash pop  
git cherry-pick <commit-id>  

---

####  Reset & Revert
git reset --soft HEAD~1  
git reset --mixed HEAD~1  
git reset --hard HEAD~1  
git revert <commit-id>  
git reflog  
