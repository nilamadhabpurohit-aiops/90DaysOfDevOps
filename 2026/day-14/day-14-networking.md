
# Day 14 – Networking Fundamentals & Hands-on Checks

## 1. OSI vs TCP/IP Models


### OSI Model (7 layers) — More detailed
This model breaks the journey into 7 small steps:
1. Physical – The actual wires, Wi-Fi signals.
              Like the road your postman uses.
2. Data Link – MAC address, frames, error checking.
               Like writing the correct house number.
3. Network – IP address & routing.
             Like choosing the correct city and route.
4. Transport – TCP/UDP, ports, ensuring delivery.
               Like making sure the letter reaches the right person in the house.
5. Session – Starts, manages, ends communication.
             Like starting a conversation and keeping it alive.
6. Presentation – Encryption, data formatting.
                  Like translating language so both sides understand.
7. Application – Apps like browser, email, HTTP, DNS.
                 The actual letter content you want to send.



### TCP/IP Model (4 layers) — What we actually use
This is the simplified, practical version used on the internet:
1. Link – Physical + Data Link combo
          Wires, Wi-Fi, MAC.
2. Internet – IP, routing
              Choosing the best path for the data.
3. Transport – TCP/UDP
               Ensures your message is delivered properly.
4. Application – HTTP, DNS, SSH, browser, API


### Protocol Layer Mapping
- IP → Internet Layer
- TCP/UDP → Transport Layer
- HTTP/HTTPS, DNS, SSH → Application Layer

### Real Example
`curl https://google.com` → Application (HTTP) → Transport (TCP) → Internet (IP) → Link (Ethernet)

---

## 2. Hands-on Networking Checklist

### Identity
```
ubuntu@ip-172-31-17-136:~$ hostname -I
172.31.17.136
```
Observation: Shows local IP address.

### Reachability
```
ubuntu@ip-172-31-17-136:~$ ping google.com -c 4
PING google.com (142.251.16.113) 56(84) bytes of data.
64 bytes from bl-in-f113.1e100.net (142.251.16.113): icmp_seq=1 ttl=105 time=1.05 ms
64 bytes from bl-in-f113.1e100.net (142.251.16.113): icmp_seq=2 ttl=105 time=1.07 ms
64 bytes from bl-in-f113.1e100.net (142.251.16.113): icmp_seq=3 ttl=105 time=1.08 ms
64 bytes from bl-in-f113.1e100.net (142.251.16.113): icmp_seq=4 ttl=105 time=1.10 ms

--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 1.046/1.074/1.099/0.018 ms
```
Observation: Check latency & packet loss.

### Path
```
ubuntu@ip-172-31-17-136:~$ traceroute google.com
traceroute to google.com (142.251.16.100), 30 hops max, 60 byte packets
 1  240.3.180.37 (240.3.180.37)  1.168 ms 240.3.180.9 (240.3.180.9)  1.990 ms 240.3.180.36 (240.3.180.36)  1.131 ms
 2  99.82.14.76 (99.82.14.76)  1.095 ms 99.82.14.178 (99.82.14.178)  1.005 ms 99.82.14.78 (99.82.14.78)  1.144 ms
 3  99.82.14.77 (99.82.14.77)  0.750 ms  0.714 ms  0.703 ms
 4  142.251.252.71 (142.251.252.71)  1.661 ms 216.239.63.169 (216.239.63.169)  0.990 ms 192.178.84.149 (192.178.84.149)  1.304 ms
 5  192.178.243.2 (192.178.243.2)  1.424 ms 192.178.242.24 (192.178.242.24)  1.594 ms 192.178.248.40 (192.178.248.40)  1.199 ms
 6  142.251.49.71 (142.251.49.71)  1.751 ms 142.251.49.157 (142.251.49.157)  1.151 ms 216.239.49.197 (216.239.49.197)  1.562 ms
 7  142.250.215.195 (142.250.215.195)  4.477 ms 142.250.215.191 (142.250.215.191)  2.137 ms 142.251.226.101 (142.251.226.101)  2.993 ms
 8  216.239.42.5 (216.239.42.5)  1.905 ms 142.250.209.63 (142.250.209.63)  4.099 ms 142.250.209.104 (142.250.209.104)  1.999 ms
 9  142.251.68.19 (142.251.68.19)  2.289 ms 142.251.68.13 (142.251.68.13)  1.403 ms  1.365 ms
10  * * *
11  * * *
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  bl-in-f100.1e100.net (142.251.16.100)  1.550 ms *  1.520 ms
```
Observation: Look for long hops/timeouts.

### Ports
```
ubuntu@ip-172-31-17-136:~$ ss -tulpn | head
Netid State  Recv-Q Send-Q      Local Address:Port Peer Address:PortProcess
udp   UNCONN 0      0               127.0.0.1:323       0.0.0.0:*
udp   UNCONN 0      0              127.0.0.54:53        0.0.0.0:*
udp   UNCONN 0      0           127.0.0.53%lo:53        0.0.0.0:*
udp   UNCONN 0      0      172.31.17.136%ens5:68        0.0.0.0:*
udp   UNCONN 0      0                   [::1]:323          [::]:*
tcp   LISTEN 0      4096        127.0.0.53%lo:53        0.0.0.0:*
tcp   LISTEN 0      4096              0.0.0.0:22        0.0.0.0:*
tcp   LISTEN 0      4096           127.0.0.54:53        0.0.0.0:*
tcp   LISTEN 0      4096                 [::]:22           [::]:*
```
Observation: Identify one listening port.

### DNS Resolution
```
ubuntu@ip-172-31-17-136:~$ dig google.com

; <<>> DiG 9.18.39-0ubuntu0.24.04.2-Ubuntu <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 22971
;; flags: qr rd ra; QUERY: 1, ANSWER: 6, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;google.com.			IN	A

;; ANSWER SECTION:
google.com.		62	IN	A	142.251.111.139
google.com.		62	IN	A	142.251.111.113
google.com.		62	IN	A	142.251.111.100
google.com.		62	IN	A	142.251.111.138
google.com.		62	IN	A	142.251.111.101
google.com.		62	IN	A	142.251.111.102

;; Query time: 2 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sun Feb 08 11:48:49 UTC 2026
;; MSG SIZE  rcvd: 135

ubuntu@ip-172-31-17-136:~$ nslookup google.com
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
Name:	google.com
Address: 142.251.111.139
Name:	google.com
Address: 142.251.111.138
Name:	google.com
Address: 142.251.111.102
Name:	google.com
Address: 142.251.111.101
Name:	google.com
Address: 142.251.111.100
Name:	google.com
Address: 142.251.111.113
Name:	google.com
Address: 2607:f8b0:4004:c17::66
Name:	google.com
Address: 2607:f8b0:4004:c17::64
Name:	google.com
Address: 2607:f8b0:4004:c17::8b
Name:	google.com
Address: 2607:f8b0:4004:c17::71
```
Observation: IP resolved.

### HTTP Check
```
ubuntu@ip-172-31-17-136:~$ curl -I https://google.com
HTTP/2 301
location: https://www.google.com/
content-type: text/html; charset=UTF-8
content-security-policy-report-only: object-src 'none';base-uri 'self';script-src 'nonce-1CHlHAEae4NyQRDgtwIfbg' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
reporting-endpoints: default="//www.google.com/httpservice/retry/jserror?ei=W3iIaaWNDM7j5NoPp9bE8QI&cad=crash&error=Page%20Crash&jsel=1"
date: Sun, 08 Feb 2026 11:49:47 GMT
expires: Tue, 10 Mar 2026 11:49:47 GMT
cache-control: public, max-age=2592000
server: gws
content-length: 220
x-xss-protection: 0
x-frame-options: SAMEORIGIN
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000
```
Observation: Check HTTP status code (200, 301, etc.)

### Connection Snapshot
```
ubuntu@ip-172-31-17-136:~$ netstat -an | head
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.54:53           0.0.0.0:*               LISTEN
tcp        0      0 172.31.17.136:38052     34.237.137.22:80        TIME_WAIT
tcp        0    484 172.31.17.136:22        171.76.80.62:27957      ESTABLISHED
tcp        0      0 172.31.17.136:53770     142.251.111.101:443     TIME_WAIT
tcp6       0      0 :::22                   :::*                    LISTEN
udp        0      0 127.0.0.1:323           0.0.0.0:*
```
Observation: Count ESTABLISHED vs LISTEN states.

---

## 3. Mini Task – Port Probe

### Identify a Listening Port
Example from ss -tulpn output:
Port 22 (SSH) is listening

### Test Port Reachability
```
ubuntu@ip-172-31-17-136:~$ nc -zv localhost 22
Connection to localhost (127.0.0.1) 22 port [tcp/ssh] succeeded!
```
Observation: If unreachable → If it wasn’t, the next step would be to check whether the service is running or if the firewall is blocking it.
(Note : in AWS we can check the security group)
---

## 4. Reflection



### Fastest Signal When Something Breaks
- `Ping` for connectivity issues.
- `Curl` for application-level issues.

### If DNS Fails → Next Layer
- Check IP connectivity (Layer 3).
- Inspect DNS config & server reachability.

### If HTTP 500 Appears
- HTTP 500 means server-side error, not a network issue.
- Usually caused by app logic, backend, database, or misconfiguration.

### Two Follow-up Checks in a Real Incident
1. `curl -v <URL>` for detailed debugging.
2. `journalctl -u <service>` or container logs.

