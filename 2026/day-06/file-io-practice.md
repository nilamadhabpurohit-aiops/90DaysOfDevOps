# Day 06 – Linux Fundamentals: Read and Write Text Files

## Steps as per the Task given : 

- Create a file named notes.txt
- Write 3 lines into the file using redirection (> and >>)
- Use cat to read the full file
- Use tee once to write and display at the same time
- Use head and tail to read parts of the file


```bash
ubuntu@ip-172-31-25-161:~$ touch notes.txt # Creates an empty file named notes.txt
ubuntu@ip-172-31-25-161:~$ echo "This is line 1" > notes.txt #Writes the first line to the file (overwrites if file exists)
ubuntu@ip-172-31-25-161:~$ echo "This is line 2" >> notes.txt #Appends a second line to the file
ubuntu@ip-172-31-25-161:~$ echo "This is line 2" >> notes.txt
ubuntu@ip-172-31-25-161:~$ echo "This is line 2" >> notes.txt
ubuntu@ip-172-31-25-161:~$ echo "This is line 3" | tee -a notes.txt #Displays the text and appends it to the file
This is line 3
ubuntu@ip-172-31-25-161:~$ cat notes.txt #Displays all contents of the file
This is line 1
This is line 2
This is line 2
This is line 2
This is line 3
ubuntu@ip-172-31-25-161:~$ head -n 2 notes.txt #Shows the first two lines of the file
This is line 1
This is line 2
ubuntu@ip-172-31-25-161:~$ tail -n 2 notes.txt #Shows the last two lines of the file
This is line 2
This is line 3
ubuntu@ip-172-31-25-161:~$

```
