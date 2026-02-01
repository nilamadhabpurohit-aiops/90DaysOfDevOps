# Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment

---

## Part 1: Launch Cloud Instance & SSH Access

### Step 1: Create Cloud Instance
- Launched an Ubuntu cloud instance using AWS EC2.
- Selected SSH (22) and HTTP (80) access in security group

### Step 2: Connect via SSH
```bash
ssh -i your-key.pem ubuntu@<your-instance-ip>
```
Observation: Successfully connected to the cloud server via SSH

Snap : 
<img width="2362" height="1462" alt="image" src="https://github.com/user-attachments/assets/ab3c3f11-7c90-4c0f-bfe8-b0740fef426f" />


## Part 2: Install Docker & Nginx

1. System Update
```bash
sudo apt update
```
2. Install Docker and Nginx
```bash
sudo apt install docker.io
sudo apt install nginx
```

4. Verify Nginx is running:
```bash
systemctl status nginx
```
Observation: Nginx service is active and running

## Part 3: Security Group Configuration

Allowed inbound traffic on port 80 (HTTP)

Opened browser and visited:
```
http://54.90.216.12/
```
<img width="2244" height="860" alt="image" src="https://github.com/user-attachments/assets/7e25e7ea-b242-4891-a322-5b55ecf87e78" />


## Part 4: Extract Nginx Logs

Step 1: View Nginx Logs
```bash
sudo cat /var/log/nginx/access.log
```
Step 2: Save Logs to File
```bash
sudo cat /var/log/nginx/access.log > nginx-logs.txt
```
Step 3: Download Log File (Local Machine)
```bash 
scp -i DevOps-linux-practice-server.pem  ubuntu@54.90.216.12:~/nginx-logs.txt . #AWS
```

## Commands Used
- ssh - To connet the server from local
- sudo apt update - To update the system package
- sudo apt install nginx/docker - Install nginx and docker 
- systemctl status nginx - To Check the service status
- cat /var/log/nginx/access.log - To check the nginx log
- scp - for secure copy to local machine

## Challenges Faced: 
- Initially web page was not accessible-
- Fixed by allowing port 80 in the security group to anywhere. 

## What I Learned
- How to launch and access a cloud server
- How to install and verify Nginx
- Importance of security group configuration
- How to access and extract service logs
- How real web servers are deployed in production
