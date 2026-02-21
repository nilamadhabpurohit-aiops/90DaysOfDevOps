# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab

## Objective
Apply shell scripting skills to real-world tasks like log rotation, backup automation, and scheduling using cron.

---

# Task 1: Log Rotation Script

##### log_rotate.sh

```bash
#!/bin/bash

# Check arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

LOG_DIR=$1

# Check directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory does not exist"
    exit 1
fi

# Compress .log files older than 7 days
compressed=$(find "$LOG_DIR" -name "*.log" -mtime +7 -exec gzip {} \; | wc -l)

# Delete .gz files older than 30 days
deleted=$(find "$LOG_DIR" -name "*.gz" -mtime +30 -delete)

echo "Compressed files older than 7 days"
echo "Deleted old compressed files"
```

## Task 2: Server Backup Script
#### backup.sh

```bash
#!/bin/bash

# Check arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_destination>"
    exit 1
fi

SOURCE=$1
DEST=$2

# Check source exists
if [ ! -d "$SOURCE" ]; then
    echo "Error: Source directory not found"
    exit 1
fi

# Create destination if not exists
mkdir -p "$DEST"

# Timestamp
DATE=$(date +%Y-%m-%d)
ARCHIVE="backup-$DATE.tar.gz"

# Create backup
tar -czf "$DEST/$ARCHIVE" "$SOURCE"

# Verify backup
if [ -f "$DEST/$ARCHIVE" ]; then
    echo "Backup created: $ARCHIVE"
    du -h "$DEST/$ARCHIVE"
else
    echo "Backup failed"
fi

# Delete backups older than 14 days
find "$DEST" -name "backup-*.tar.gz" -mtime +14 -delete

```


## Task 3: Crontab
#### Current Scheduled Jobs

```bash
# Command 
crontab -l
#Syntax 
Cron Syntax
* * * * *  command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
0 2 * * * /path/log_rotate.sh /var/log/myapp #Run log rotation daily at 2 AM
0 3 * * 0 /path/backup.sh /data /backup #Run backup every Sunday at 3 AM
*/5 * * * * /path/health_check.sh #Health check every 5 minutes

```

## Task 4: Maintenance Script
#### maintenance.sh

```bash
#!/bin/bash

LOGFILE="/var/log/maintenance.log"

echo "$(date): Maintenance started" >> "$LOGFILE"

# Call log rotation
/path/log_rotate.sh /var/log/myapp >> "$LOGFILE" 2>&1

# Call backup
/path/backup.sh /data /backup >> "$LOGFILE" 2>&1

echo "$(date): Maintenance completed" >> "$LOGFILE"
#Cron Entry for Maintenance Script
0 1 * * * /path/maintenance.sh

```


### What I Learned
- Automated log rotation and backups improve system reliability.
- Cron helps schedule tasks without manual intervention.
- Error handling and validation are important for production scripts.