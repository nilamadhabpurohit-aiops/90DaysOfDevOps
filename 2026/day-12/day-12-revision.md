# Day 12 – Breather & Revision (Days 01–11)

---

## 1. Mindset & Learning Plan Review

- Initial goal: Linux fundamentals for DevOps
- Current status: Comfortable with processes management, services management, files permissions, and files ownership
- Plan tweak:
  - Spend more time practicing troubleshooting scenarios
  - Revise file permissions and file ownership regularly (chmod, chown, chgrp)

---

## 1. Processes & Services (Re-run Practice)

Commands Run : 
```bash
ps aux | head
systemctl status ssh
journalctl -u ssh -n 10
```
Observations:
- systemd is running as PID 1
- SSH service is active and healthy
- Logs show successful service start with no errors

## 2. File Skills (Quick Practice)
Commands Run :
```bash
echo "revision test" >> notes.txt
chmod 640 notes.txt
chown tokyo:developers notes.txt
ls -l notes.txt
```
Observations:
- File append using >> works as expected
- Permissions and ownership changes reflected correctly
- ls -l is the quickest way to verify changes

## 3. Cheat Sheet Refresh (Day 03)
Top 5 Commands Use First in an Incident
- top → Check CPU and memory usage
- ps aux → Inspect running processes
- systemctl status <service> → Check service health
- journalctl -u <service> → View service logs
- df -h → Check disk usage

## 4. User / Group Sanity Check
- Practice Performed
```bash
sudo useradd -m nilamadhab
- id nilamadhab
- ls -ld /home/nilamadhab
```
Observation:
- User created successfully
- Home directory exists
- Ownership and permissions are correct

## 5. Mini Self-Check
1. Three commands that save me the most time

- systemctl status →  service health check
- journalctl -u → fastest way to find errors of service 
- ls -l → permissions and ownership verification of files

2. How do I check if a service is healthy?
```bash 
systemctl status <service>
journalctl -u <service> -n 20
ps aux | grep <service>
```
3. How to safely change ownership and permissions?
Example:
```
sudo chown tokyo:developers app.log
chmod 640 app.log
```
Ensures correct owner/group and controlled access
