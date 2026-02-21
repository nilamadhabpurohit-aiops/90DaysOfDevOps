# Day 26 – GitHub CLI (gh): Manage GitHub from Terminal

---

## Task 1: Install and Authenticate

### Installation
I installed GitHub CLI using the package manager.

Example (Mac):
brew install gh

Example (Linux):
sudo apt install gh

---

### Authentication
I authenticated using:

gh auth login

I followed the interactive steps:
- GitHub.com
- HTTPS
- Login via browser

---

### Verification
To verify login:

gh auth status

This confirmed my active GitHub account.

---

### Authentication methods supported by gh
GitHub CLI supports:
- Browser-based OAuth login
- Personal Access Token (PAT)
- SSH authentication
- GitHub Enterprise authentication

---

---

## Task 2: Working with Repositories

### Create a new repo from terminal
gh repo create test-gh-repo --public --clone --readme

This created a public repo with a README and cloned it locally.

---

### Clone a repo using gh
gh repo clone owner/repository-name

---

### View repo details
gh repo view

This shows:
- Description
- Visibility
- Stars
- URL

---

### List all repositories
gh repo list

--- 

### Open repo in browser
gh repo view --web

---

### Delete the test repo
gh repo delete owner/test-gh-repo

---

---

## Task 3: Issues

### Create an issue
gh issue create --title "Test Issue" --body "Created using GitHub CLI" --label "bug"

---

### List open issues
gh issue list

---

### View a specific issue
gh issue view 1

---

### Close an issue
gh issue close 1

---

### How gh issue can be used in automation?
It can be used to:
- Automatically create issues when pipelines fail
- Create tickets from monitoring alerts
- Integrate with CI/CD and incident management
- Automate bug tracking in DevOps workflows

---

---

## Task 4: Pull Requests

### Create a branch and change
git checkout -b feature-gh
echo "New change" >> file.txt
git add .
git commit -m "Feature using gh"
git push origin feature-gh

---

### Create a pull request from terminal
gh pr create --fill

---

### List open PRs
gh pr list

---

### View PR details
gh pr view

---

### Merge PR from terminal
gh pr merge

---

### Merge methods supported
gh supports:
- Merge commit
- Squash merge
- Rebase merge

---

### How to review someone else’s PR
- List PRs using gh pr list
- Checkout PR branch:
  gh pr checkout <number>
- Review code locally
- Add comments and approve using:
  gh pr review

---

---

## Task 5: GitHub Actions & Workflows (Preview)

### List workflow runs
gh run list

---

### View workflow details
gh run view <run-id>

---

### Use in CI/CD
gh run and gh workflow can:
- Monitor pipeline status
- Trigger workflows
- Debug failures from terminal
- Automate deployment pipelines
- Integrate with DevOps automation scripts

---

---

## Task 6: Useful gh Tricks

### Raw API calls
gh api repos/{owner}/{repo}

---

### GitHub Gists
gh gist create file.txt

---

### Releases
gh release create v1.0

---

### Alias
gh alias set prlist "pr list"

---

### Search repositories
gh search repos devops

---

---

## Key Learnings

- GitHub CLI improves productivity by avoiding browser context switching.
- Useful for automation, scripting, and CI/CD.
- Essential for DevOps engineers working at scale.
