# Day 16 – Shell Scripting Basics

### Task 1: Your First Script
1. Create a file `hello.sh`
2. Add the shebang line `#!/bin/bash` at the top
3. Print `Hello, DevOps!` using `echo`
4. Make it executable and run it



```bash
ubuntu@ip-172-31-17-136:~/scripts$ vim hello.sh
ubuntu@ip-172-31-17-136:~/scripts$ cat hello.sh
#!/bin/bash
echo  "Hello, DevOps!"
ubuntu@ip-172-31-17-136:~/scripts$ chmod +x hello.sh
ubuntu@ip-172-31-17-136:~/scripts$ sh hello.sh
Hello, DevOps!

```

**Document:** What happens if you remove the shebang line?

- If the shebang is removed from a script, the following may occur: 
Default Shell: The script may be executed using the default shell of the user (often /bin/sh or /bin/bash ). This can lead to unexpected behavior if the script contains syntax or commands specific to a different shell or interpreter.
- If we remove #!/bin/bash, the script may still run when executed with bash hello.sh, but running ./hello.sh may fail or use a different shell.
- The shebang tells the system which interpreter to use.

---

### Task 2: Variables
1. Create `variables.sh` with:
   - A variable for your `NAME`
   - A variable for your `ROLE` (e.g., "DevOps Engineer")
   - Print: `Hello, I am <NAME> and I am a <ROLE>`
```
ubuntu@ip-172-31-17-136:~/scripts$ sh variable.sh
Hello, I am Nilamadhab and I am a Implementaion Engineer
ubuntu@ip-172-31-17-136:~/scripts$ vim variable.sh
ubuntu@ip-172-31-17-136:~/scripts$ sh variable.sh
Hello, I am $NAME and I am a $ROLE
```
2. Try using single quotes vs double quotes — what's the difference?
- Single quotes do not expand variables.
- Double quotes expand variables.

---

### Task 3: User Input with read
1. Create `greet.sh` that:
   - Asks the user for their name using `read`
   - Asks for their favourite tool
   - Prints: `Hello <name>, your favourite tool is <tool>`
```
ubuntu@ip-172-31-17-136:~/scripts$ ./greet.sh
What is your Favorite Tool: k8s
Hello NILAMADHAB, your favourite tool is k8s.
```
---

### Task 4: If-Else Conditions
1. Create `check_number.sh` that:
   - Takes a number using `read`
   - Prints whether it is **positive**, **negative**, or **zero**
```
ubuntu@ip-172-31-17-136:~/scripts$ ./check_number.sh
Enter a Number: 12
Given No is Positive
ubuntu@ip-172-31-17-136:~/scripts$ ./check_number.sh
Enter a Number: -3
Given No is Negetive

```
2. Create `file_check.sh` that:
   - Asks for a filename
   - Checks if the file **exists** using `-f`
   - Prints appropriate message
```
ubuntu@ip-172-31-17-136:~/scripts$ ./file_check.sh
Enter the file name with path: hello.sh
File is exesist
ubuntu@ip-172-31-17-136:~/scripts$ ./file_check.sh
Enter the file name with path: bye.sh
File is not Exesist
```
---

### Task 5: Combine It All
Create `server_check.sh` that:
1. Stores a service name in a variable (e.g., `nginx`, `sshd`)
2. Asks the user: "Do you want to check the status? (y/n)"
3. If `y` — runs `systemctl status <service>` and prints whether it's **active** or **not**
4. If `n` — prints "Skipped."
```
ubuntu@ip-172-31-17-136:~/scripts$ ./server_check.sh
Enter the Service Name: nginx
Do you want to check the status? (y/n)y
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: enabled)
     Active: active (running) since Sat 2026-02-14 11:41:05 UTC; 4min 54s ago
       Docs: man:nginx(8)
    Process: 1827 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Process: 1830 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
   Main PID: 1883 (nginx)
      Tasks: 3 (limit: 1017)
     Memory: 2.4M (peak: 5.3M)
        CPU: 28ms
     CGroup: /system.slice/nginx.service
             ├─1883 "nginx: master process /usr/sbin/nginx -g daemon on; master_process on;"
             ├─1885 "nginx: worker process"
             └─1886 "nginx: worker process"

Feb 14 11:41:05 ip-172-31-17-136 systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Feb 14 11:41:05 ip-172-31-17-136 systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
ubuntu@ip-172-31-17-136:~/scripts$
```
---

## Hints
- Shebang: `#!/bin/bash` tells the system which interpreter to use
- Variables: `NAME="Shubham"` (no spaces around `=`)
- Read: `read -p "Enter name: " NAME`
- If syntax: `if [ condition ]; then ... elif ... else ... fi`
- File check: `if [ -f filename ]; then`

---

## What you learned (3 key points)
1. Shebang (#!/bin/bash) ensures the correct interpreter runs the script.
2. Variables and user input make scripts dynamic and reusable.
3. If-else conditions help automate decision-making in real DevOps tasks.
4. All the Scripts are in the Repo : https://github.com/nilamadhab1996/Shell-Scripts-Basic-Advance/tree/main/Task_90_Days_Devops/Day-16 