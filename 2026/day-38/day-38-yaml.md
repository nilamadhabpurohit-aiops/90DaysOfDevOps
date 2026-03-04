# Day 38 – YAML Basics

## Overview
Today I learned the fundamentals of YAML syntax, which is widely used in DevOps tools such as Kubernetes, GitHub Actions, and CI/CD pipelines.

---

## Task 1: Key-Value Pairs

Example YAML file:

```yaml
name: Nilamadhab Purohit
role: Senior Implementation Analyst
experience_years: 5
learning: true
```

Key-value pairs are the basic structure of YAML.

---

## Task 2: Lists

Example list formats:

Block list:

```yaml
tools:
  - docker
  - kubernetes
  - linux
```

Inline list:

```yaml
hobbies: [gym, reading, learning-devops]
```

### Two ways to write lists in YAML
1. Block format using `-`
2. Inline format using `[ ]`

---

## Task 3: Nested Objects

Example nested YAML:

```yaml
server:
  name: devops-server
  ip: 192.168.1.10
  port: 8080

database:
  host: db.internal
  name: payment_db
  credentials:
    user: admin
    password: securepassword
```

YAML uses indentation to represent hierarchy.

---

## Task 4: Multi-line Strings

Block style (`|`) preserves line breaks.

```yaml
startup_script: |
  echo "start"
  docker compose up
```

Fold style (`>`) converts lines into a single line.

```yaml
startup_script: >
  echo "start"
  docker compose up
```

### When to use each
`|` → when exact formatting matters (scripts, configs)  
`>` → when you want text folded into one line

---

## Task 5: YAML Validation

Used `yamllint` to validate files.

Example command:

```
yamllint person.yaml
yamllint server.yaml
```

Common issue:
Using **tabs instead of spaces** causes validation errors.

---

## Task 6: Spot the Difference

Correct YAML:

```yaml
tools:
  - docker
  - kubernetes
```

Broken YAML:

```yaml
tools:
- docker
  - kubernetes
```

### Issue
Indentation is inconsistent. YAML requires consistent spacing.

---

## Key Learnings

1. YAML is indentation-based and uses spaces only.
2. Lists can be written in block or inline format.
3. YAML validation tools help detect formatting errors early.

