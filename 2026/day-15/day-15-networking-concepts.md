# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

---

## Task 1: DNS – How Names Become IPs

### What Happens When You Type google.com in a Browser?

1. Your browser asks the OS to resolve google.com.
2. The OS checks local cache or DNS resolver.
3. DNS server returns the IP address of google.com.
4. Browser connects to that IP using HTTP/HTTPS over TCP.

---

### DNS Record Types

- *A* → Maps domain name to IPv4 address.
- *AAAA* → Maps domain name to IPv6 address.
- *CNAME* → Alias of one domain to another.
- *MX* → Mail server record.
- *NS* → Name server record (authoritative DNS server).

---

### Command
```bash
dig google.com                                                                                      ─╯

; <<>> DiG 9.10.6 <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 55745
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;google.com.			IN	A

;; ANSWER SECTION:
google.com.		92	IN	A	142.250.207.238

;; Query time: 27 msec
;; SERVER: 2401:4900:50:9::66#53(2401:4900:50:9::66)
;; WHEN: Thu Feb 12 20:40:34 IST 2026
;; MSG SIZE  rcvd: 55
```
- A Record IP: 142.250.183.14
- TTL: 300 seconds

## Task 2: IP Addressing

### What is an IPv4 Address?
- An IPv4 address is a 32-bit number written in four parts separated by dots.
Example: 192.168.1.10
- Each part ranges from 0 to 255.

### Public vs Private IP
- *Public IP* → Accessible from the internet.
- Example: 8.8.8.8
- *Private IP* → Used inside private networks.
- Example: 192.168.1.10

Private IP Ranges

- 10.0.0.0 – 10.255.255.255
- 172.16.0.0 – 172.31.255.255
- 192.168.0.0 – 192.168.255.255

```
ipconfig getifaddr en0                                                                              ─╯
192.168.1.4
ifconfig | grep inet                                                                                ─╯
	inet 127.0.0.1 netmask 0xff000000
	inet6 ::1 prefixlen 128
	inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1
	inet6 fe80::c2c:7336:b397:c503%en0 prefixlen 64 secured scopeid 0xe
	inet 192.168.1.4 netmask 0xffffff00 broadcast 192.168.1.255
	inet6 2401:4900:1f29:c1dd:1cd6:9828:6bcb:1273 prefixlen 64 autoconf secured
	inet6 2401:4900:1f29:c1dd:a0ae:589:9f5b:6ce0 prefixlen 64 autoconf temporary
	inet6 fe80::2837:46ff:fe86:50aa%awdl0 prefixlen 64 scopeid 0x10
	inet6 fe80::2837:46ff:fe86:50aa%llw0 prefixlen 64 scopeid 0x11
	inet6 fe80::d30d:7fd7:6bdd:99e0%utun0 prefixlen 64 scopeid 0x12
	inet6 fe80::f1d6:c0dd:6854:d0fe%utun1 prefixlen 64 scopeid 0x13
	inet6 fe80::fcb6:53f6:60cb:2566%utun2 prefixlen 64 scopeid 0x14
	inet6 fe80::ce81:b1c:bd2c:69e%utun3 prefixlen 64 scopeid 0x15
```
Observation
- My system IP: 192.168.1.4
- This falls under 172.16–172.31 range → Private IP

## Task 3: CIDR & Subnetting
### What Does /24 Mean?
- 192.168.1.0/24 means:
- First 24 bits are network bits
- Last 8 bits are host bits

### Usable Hosts

- /24 → 256 total IPs → 254 usable hosts
- /16 → 65,536 total IPs → 65,534 usable hosts
- /28 → 16 total IPs → 14 usable hosts
- (2 IPs reserved: Network + Broadcast)

### Why Do We Subnet?
- To divide networks into smaller parts
- To improve security
- To reduce broadcast traffic
- To manage IP addresses efficiently

### CIDR Table
CIDR	Subnet Mask	Total IPs	Usable Hosts
CIDR	Subnet Mask	Total IPs	Usable Hosts
| CIDR | Subnet Mask     | Total IPs | Usable Hosts |
|------|-----------------|-----------|--------------|
| /24  | 255.255.255.0   | 256       | 254          |
| /16  | 255.255.0.0     | 65536     | 65534        |
| /28  | 255.255.255.240 | 16        | 14           |

## Task 4: Ports – The Doors to Services
### What is a Port?
A port is a logical number used to identify a specific service running on a system.
IP = house address
Port = door number
Common Ports

| Port | Service |
|------|---------|
| 22   | SSH     |
| 80   | HTTP    |
| 443  | HTTPS   |
| 53   | DNS     |
| 3306 | MySQL   |
| 6379 | Redis   |
| 27017| MongoDB |

Command
```
ss -tulpn
```
Sample Observation
Port 22 → SSH service listening
Port 53 → DNS service listening

## Task 5: Putting It Together

### curl http://myapp.com:8080
### What Concepts Are Used?
- DNS resolves myapp.com to IP
- TCP connection established
- Port 8080 identify the application
- HTTP runs at application layer

### App Can't Reach Database at 10.0.1.50:3306 – What to Check?
- Is port 3306 open?
- Is the database service running?
- Is firewall/security group allowing traffic?
- Is IP correct and reachable (ping / telnet)?
