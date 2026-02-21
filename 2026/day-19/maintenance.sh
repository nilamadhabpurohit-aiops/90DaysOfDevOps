#!/usr/bin/env bash
set -euo pipefail

usage() { echo "Usage: $0 <log_dir> <backup_src> <backup_dest>"; exit 1; }

LOG_DIR="${1:-}"
BACKUP_SRC="${2:-}"
BACKUP_DEST="${3:-}"

[[ -z "$LOG_DIR" || -z "$BACKUP_SRC" || -z "$BACKUP_DEST" ]] && usage

LOGFILE="/var/log/maintenance.log"
# Try to create the logfile; if not permitted, fall back to $HOME
if ! { mkdir -p "$(dirname "$LOGFILE")" 2>/dev/null && touch "$LOGFILE" 2>/dev/null; }; then
  LOGFILE="$HOME/maintenance.log"
  touch "$LOGFILE"
  echo "Warning: no permission for /var/log. Logging to $LOGFILE" >&2
fi

# Prefix each output line with a timestamp and append to the logfile
exec > >(while IFS= read -r line; do printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$line"; done >> "$LOGFILE") 2>&1

echo "=== Maintenance started ==="
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/log_rotate.sh" "$LOG_DIR"
"$SCRIPT_DIR/backup.sh" "$BACKUP_SRC" "$BACKUP_DEST"

echo "=== Maintenance finished ==="