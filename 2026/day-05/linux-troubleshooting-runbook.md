# Day 05 – Linux Troubleshooting Runbook

## Target Service
- Service: SSH (`ssh.service`)
- Purpose: Remote access to the server
  
---

## 1. Environment Basics

### Commands
```bash
uname -a
cat /etc/os-release
```

### Snap :
<img width="2294" height="660" alt="image" src="https://github.com/user-attachments/assets/d0086dc0-3074-479f-ad38-1cee0cd1eef3" />

### Observation:
- Confirms kernel version and architecture
- System is running Linux on x86_64
- OS is Ubuntu Linux
- Confirms distribution and version

##  2. Filesystem Sanity

### Commands
```bash
mkdir /tmp/runbook-demo
cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo
```
### Snap :
<img width="1796" height="202" alt="image" src="https://github.com/user-attachments/assets/d6f65d51-f57b-43f5-9259-05028a7a891a" />

### Observation:
- Filesystem is writable
- Basic file operations working correctly

## 3. CPU / Memory

### Commands
```bash
top
free -h 
```

### Snap :
<img width="920" height="350" alt="image" src="https://github.com/user-attachments/assets/1ed6c677-d464-4202-9096-7fa4228efc78" />
<img width="839" height="94" alt="image" src="https://github.com/user-attachments/assets/f609042b-52e7-4108-b676-e67b8fb270f1" />

### Observation:
- CPU usage is low and fine
- No zombie processes
- System appears healthy
- Sufficient free memory available
- No swap usage detected

## 4. Disk / IO

### Commands
```bash
df -h # -h means Human Readable 
sudo  du -sh /var/log
```
### Snap :
<img width="906" height="359" alt="image" src="https://github.com/user-attachments/assets/a3b491a9-ffe1-4b64-a1df-aeedbdbc9d5a" />

### Observation:
- Disk usages are fine
- No partitions are full
- Log directory size is fine
- No Error log observed

## 5. Network

** Note : `net-tools` might not be installed. Before running the below comands you have to install the same. command: `sudo apt install net-tools`

### Commands
```bash
ss -tulpn
netstat -tulpn
ping google.com
```
### Snap :
<img width="1452" height="696" alt="image" src="https://github.com/user-attachments/assets/2a0881f2-6895-4539-9dfd-4daaeea79266" />

### Observation:
- netstat shows SSH listening on port 22 for both IPv4 and IPv6
- PNetwork sockets are in a normal state
- Local DNS resolver is active on 127.0.0.53 / 127.0.0.54
- ss confirms the same listening ports with no unexpected services
- No unknown ports are open
- ping to google.com succeeds with low latency, network connectivity is fine

## 6. Logs

### Commands
```bash
journalctl -u ssh -n 50
tail -n 50 /var/log/auth.log
```
### Snap :
<img width="2932" height="1124" alt="image" src="https://github.com/user-attachments/assets/20bae4f1-b7b5-4a1e-877b-8ad76e6a9de1" />

### Observation:
- SSH service started successfully
- No recent errors found
- Successful login entries present
- No failed auth attempts


## Quick Findings
- SSH service is running and listening on port 22 (IPv4 and IPv6)
- CPU and memory usage are normal with no resource pressure
- Disk usage and log directory size are within safe limits
- Network connectivity is healthy with successful outbound access
- No errors or failures found in recent SSH logs

## If This Worsens (Next Steps)
- Restart SSH service and monitor CPU, memory, and logs after restart
- Increase SSH log verbosity and recheck authentication and error logs
- Capture deeper diagnostics using ss, lsof, or strace for SSH processes
