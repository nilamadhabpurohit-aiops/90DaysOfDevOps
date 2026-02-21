# Day 22 – Introduction to Git (Intermediate Notes)

Today I worked on strengthening my fundamentals of Git. I’ve used Git before, but this task helped me understand more clearly how Git actually manages files, states, and history internally.

---

## 🔹 1. Difference between `git add` and `git commit`
- `git add` moves selected changes into the **staging area**, allowing me to prepare exactly what should be included in the next commit.
- `git commit` permanently records those staged changes into the repository’s history with a message.

In short:  
**add = prepare changes**  
**commit = save changes**

---

## 🔹 2. What does the staging area do?
The staging area (also called the index) allows controlled commits. Git doesn’t directly commit because:
- I might not want to commit all changed files.
- It helps create cleaner commit histories.
- It gives me a chance to review changes before saving them permanently.

---

## 🔹 3. What does `git log` show?
`git log` displays:
- Commit history (latest to oldest)
- Commit SHA (unique ID)
- Author and timestamp
- Commit message

With extra flags like `--oneline` or `--graph`, it becomes easier to visualize branches and history.

---

## 🔹 4. What is the `.git/` folder?
This folder contains the full repository metadata:
- All commit objects  
- Branch references  
- Staging index  
- Configuration  
- HEAD pointer  

If the `.git/` folder is deleted, the project becomes a **normal folder** with no history or Git tracking.

---

## 🔹 5. Difference between Working Directory, Staging Area, Repository

### **Working Directory**
Where I edit files normally on my system.

### **Staging Area**
Where Git temporarily stores changes that are ready to be committed.

### **Repository**
Where committed versions and full history are stored under `.git/`.

A simple mental model:

```
Working Directory → Staging Area → Repository
       (edit)           (prepare)        (save)
```

---

## Key Takeaways
- Git is powerful because of its **three‑area architecture**.  
- Clean commit history is easier when using staging properly.  
- Exploring the `.git` folder helped me understand that Git is basically a database of objects.
