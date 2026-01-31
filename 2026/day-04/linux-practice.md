# Day 04 – My Linux Practice

## 1. Process Checks

### Command 1: Check running processes (ps, top, pgrep)
```bash
ubuntu@ip-172-31-25-161:~$ ps aux | head
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.9  1.4  22640 13840 ?        Ss   13:41   0:01 /sbin/init
root           2  0.0  0.0      0     0 ?        S    13:41   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        S    13:41   0:00 [pool_workqueue_release]
root           4  0.0  0.0      0     0 ?        I<   13:41   0:00 [kworker/R-rcu_gp]
root           5  0.0  0.0      0     0 ?        I<   13:41   0:00 [kworker/R-sync_wq]
root           6  0.0  0.0      0     0 ?        I<   13:41   0:00 [kworker/R-kvfree_rcu_reclaim]
root           7  0.0  0.0      0     0 ?        I<   13:41   0:00 [kworker/R-slub_flushwq]
root           8  0.0  0.0      0     0 ?        I<   13:41   0:00 [kworker/R-netns]
root           9  0.0  0.0      0     0 ?        I    13:41   0:00 [kworker/0:0-events]
ubuntu@ip-172-31-25-161:~$

ubuntu@ip-172-31-25-161:~$ pgrep sshd
1091
1092
1500


ubuntu@ip-172-31-25-161:~$ top
top - 13:50:19 up 9 min,  1 user,  load average: 0.05, 0.04, 0.01
Tasks: 109 total,   1 running, 108 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st 
MiB Mem :    914.2 total,    144.3 free,    358.2 used,    574.4 buff/cache     
MiB Swap:      0.0 total,      0.0 free,      0.0 used.    556.0 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                                                       
      1 root      20   0   22640  13844   9652 S   0.0   1.5   0:01.98 systemd                                                                                       
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd                
      3 root      20   0       0      0      0 S   0.0   0.0   0:00.00 pool_workqueue_release                                                                        
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/R-rcu_gp                                                                              
      5 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/R-sync_wq
```

## 1. Service Checks

```bash
ubuntu@ip-172-31-25-161:~$ systemctl status
● ip-172-31-25-161
    State: running
    Units: 413 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Sat 2026-01-31 13:41:10 UTC; 13min ago
  systemd: 255.4-1ubuntu8.11
   CGroup: /
           ├─init.scope
           │ └─1 /sbin/init
           ├─system.slice
           │ ├─ModemManager.service
           │ │ └─833 /usr/sbin/ModemManager
           │ ├─acpid.service
           │ │ └─648 /usr/sbin/acpid

ubuntu@ip-172-31-25-161:~$ systemctl status ssh
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/usr/lib/systemd/system/ssh.service; disabled; preset: enabled)
    Drop-In: /usr/lib/systemd/system/ssh.service.d
             └─ec2-instance-connect.conf
     Active: active (running) since Sat 2026-01-31 13:42:44 UTC; 15min ago
TriggeredBy: ● ssh.socket
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 1089 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 1091 (sshd)
      Tasks: 1 (limit: 1008)
     Memory: 5.5M (peak: 9.4M)

ubuntu@ip-172-31-25-161:~$ systemctl list-units --type=service --state=running
  UNIT                                           LOAD   ACTIVE SUB     DESCRIPTION                                                   
  acpid.service                                  loaded active running ACPI event daemon
  chrony.service                                 loaded active running chrony, an NTP client/server
  cron.service                                   loaded active running Regular background program processing daemon
  dbus.service                                   loaded active running D-Bus System Message Bus
  getty@tty1.service                             loaded active running Getty on tty1
  irqbalance.service                             loaded active running irqbalance daemon
  ModemManager.service                           loaded active running Modem Manager
  multipathd.service                             loaded active running Device-Mapper Multipath Device Controller
  networkd-dispatcher.service                    loaded active running Dispatcher daemon for systemd-networkd
```


## 1. log Checks

```bash
ubuntu@ip-172-31-25-161:~$ journalctl -u ssh
Jan 31 13:42:44 ip-172-31-25-161 systemd[1]: Starting ssh.service - OpenBSD Secure Shell server...
Jan 31 13:42:44 ip-172-31-25-161 sshd[1091]: Server listening on 0.0.0.0 port 22.
Jan 31 13:42:44 ip-172-31-25-161 sshd[1091]: Server listening on :: port 22.
Jan 31 13:42:44 ip-172-31-25-161 systemd[1]: Started ssh.service - OpenBSD Secure Shell server.
Jan 31 13:42:46 ip-172-31-25-161 ec2-instance-connect[1201]: Querying EC2 Instance Connect keys for matching fingerprint: SHA256:a8cmenTIQDCWtpYLEP4qzmlwoL1Q2hqib1i>
Jan 31 13:42:46 ip-172-31-25-161 ec2-instance-connect[1233]: Providing ssh key from EC2 Instance Connect with fingerprint: SHA256:a8cmenTIQDCWtpYLEP4qzmlwoL1Q2hqib1>
Jan 31 13:42:47 ip-172-31-25-161 ec2-instance-connect[1350]: Querying EC2 Instance Connect keys for matching fingerprint: SHA256:a8cmenTIQDCWtpYLEP4qzmlwoL1Q2hqib1i>
Jan 31 13:42:47 ip-172-31-25-161 ec2-instance-connect[1382]: Providing ssh key from EC2 Instance Connect with fingerprint: SHA256:a8cmenTIQDCWtpYLEP4qzmlwoL1Q2hqib1>
Jan 31 13:42:48 ip-172-31-25-161 sshd[1092]: Accepted publickey for ubuntu from 18.206.107.28 port 54800 ssh2: ED25519 SHA256:a8cmenTIQDCWtpYLEP4qzmlwoL1Q2hqib1iVoi>
Jan 31 13:42:48 ip-172-31-25-161 sshd[1092]: pam_unix(sshd:session): session opened for user ubuntu(uid=1000) by ubuntu(uid=0)


ubuntu@ip-172-31-25-161:~$ journalctl -b | head
Jan 31 13:41:11 ubuntu kernel: Linux version 6.14.0-1018-aws (buildd@lcy02-amd64-107) (x86_64-linux-gnu-gcc-13 (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #18~24.04.1-Ubuntu SMP Mon Nov 24 19:46:27 UTC 2025 (Ubuntu 6.14.0-1018.18~24.04.1-aws 6.14.11)
Jan 31 13:41:11 ubuntu kernel: Command line: BOOT_IMAGE=/vmlinuz-6.14.0-1018-aws root=PARTUUID=2baf9194-a5fb-4b12-adb0-45166f0feb06 ro console=tty1 console=ttyS0 nvme_core.io_timeout=4294967295 panic=-1
Jan 31 13:41:11 ubuntu kernel: KERNEL supported cpus:
Jan 31 13:41:11 ubuntu kernel:   Intel GenuineIntel
Jan 31 13:41:11 ubuntu kernel:   AMD AuthenticAMD
Jan 31 13:41:11 ubuntu kernel:   Hygon HygonGenuine
Jan 31 13:41:11 ubuntu kernel:   Centaur CentaurHauls
Jan 31 13:41:11 ubuntu kernel:   zhaoxin   Shanghai  
Jan 31 13:41:11 ubuntu kernel: BIOS-provided physical RAM map:
Jan 31 13:41:11 ubuntu kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
```
## Mini Troubleshooting Steps

####Problem:
Need to verify whether **SSH service* is working correctly

####Steps:
- Checked running processes using ps and pgrep
- Verified service status using systemctl status ssh
- Reviewed service logs using journalctl -u ssh
####Conclusion:
- SSH service is running normally with no errors
