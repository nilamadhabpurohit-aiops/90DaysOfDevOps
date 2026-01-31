# Linux Architecture – Quick Notes (Day 02)

## 1. Core Components of Linux

### Kernel
- The **core of Linux**
- Talks directly to hardware (CPU, memory, disk, network)
- Responsible for:
  - Process management
  - Memory management
  - Device drivers
  - System calls

### User Space
- Where **users and applications** run
- Includes:
  - Shell (bash, zsh, ksh)
  - Utilities (ls, ps, top)
  - Applications (nginx, docker, python)

### Init System (systemd)
- First user-space process started by the kernel
- PID = 1
- Manages:
  - Service startup/shutdown
  - Logging
  - System boot order
  - Service restarts

---

## 2. How Processes Are Created & Managed

- A process is a **running instance of a program**
- Created using:
  - `fork()` → creates a new process
  - `exec()` → loads a program into the process
- Each process has:
  - PID (Process ID)
  - PPID (Parent Process ID)
  - State (running, sleeping, etc.)

### Common Process States
- **Running (R)** → executing on CPU
- **Sleeping (S)** → waiting for I/O or event
- **Uninterruptible Sleep (D)** → waiting on disk/network
- **Stopped (T)** → paused manually or by signal
- **Zombie (Z)** → finished execution but not cleaned up

---

## 3. What systemd Does & Why It Matters

- Controls the **entire lifecycle of services**
- Starts services in parallel → faster boot
- Restarts failed services automatically
- Centralized logging using **journald**

Why it matters for DevOps:
- Helps debug failed services quickly
- Controls dependencies between services
- Essential for production troubleshooting

---

## 4. Daily Linux Commands (Must Know)

1. `ps aux` → view running processes
2. `top` / `htop` → monitor CPU & memory usage
3. `systemctl status <service>` → check service health
4. `journalctl -u <service>` → view service logs
5. `df -h` → check disk usage

---

## 5. Summary (DevOps Perspective)

- Linux runs almost all production systems
- Kernel manages hardware & processes
- systemd controls services and boot
- Understanding this helps:
  - Debug crashes
  - Fix performance issues
  - Handle incidents confidently
