# Linux Commands Cheat Sheet – Day 03

## 1. Process Management

- `ps aux` → List all running processes
- `ps -ef` → Process list with parent-child relationship
- `top` → Real-time CPU and memory usage
- `htop` → Improved interactive process viewer
- `pidof <process>` → Get PID of a running process
- `kill <PID>` → Terminate a process gracefully
- `kill -9 <PID>` → Force kill a process
- `nice -n 10 <command>` → Start process with priority
- `uptime` → Check system load average and uptime

---

## 2. File System & Disk

- `ls -lh` → List files with sizes
- `pwd` → Show current directory
- `df -h` → Disk usage of mounted filesystems
- `du -sh <dir>` → Size of a directory
- `mount` → Show mounted filesystems
- `find /path -name file` → Search files by name
- `chmod 755 file` → Change file permissions
- `chown user:group file` → Change ownership
- `stat file` → Detailed file metadata

---

## 3. Logs & System Troubleshooting

- `journalctl` → View system logs
- `journalctl -u <service_name>` → Logs for a specific service
- `journalctl -f` → Follow logs in real time
- `journalctl -b` → Logs from last boot
- `tail -f /var/log/syslog` → Live log monitoring
- `dmesg` → Kernel and hardware messages

---

## 4. Networking Commands

- `ip addr` → Show network interfaces and IPs
- `ip route` → Display routing table
- `ping <host_name>` or `ping google.com` → Test network connectivity
- `ss -tuln` → List listening ports and services
- `curl <url>` → Test HTTP endpoints
- `dig <domain>` → DNS lookup

---

## 5. System & User Info

- `whoami` → Show current user
- `id` → User and group details
- `free -h` → Memory usage
- `uname -a` → Kernel and OS information
- `hostnamectl` → System hostname details

---

## 6. Service Management (systemd)

- `systemctl status <service>` → Check service health
- `systemctl start <service>` → Start a service
- `systemctl stop <service>` → Stop a service
- `systemctl restart <service>` → Restart a service
- `systemctl enable <service>` → Start service on boot
