#!/usr/bin/env bash
set -euo pipefail

usage() { echo "Usage: $0 <log_directory>"; exit 1; }

LOG_DIR="${1:-}"
[[ -z "$LOG_DIR" ]] && usage

if [[ ! -d "$LOG_DIR" ]]; then
  echo "Error: directory '$LOG_DIR' does not exist" >&2
  exit 2
fi

# Count .log files older than 7 days
compressed_count=$(find "$LOG_DIR" -type f -name "*.log" -mtime +7 -print0 | tr -cd '\0' | wc -c || true)
# Compress them
if [[ "$compressed_count" -gt 0 ]]; then
  while IFS= read -r -d '' f; do
    gzip -f "$f"
  done < <(find "$LOG_DIR" -type f -name "*.log" -mtime +7 -print0)
fi

# Count .gz files older than 30 days and delete
deleted_count=$(find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -print0 | tr -cd '\0' | wc -c || true)
if [[ "$deleted_count" -gt 0 ]]; then
  find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -print0 | xargs -0 rm -f
fi

echo "Compressed files: ${compressed_count}"
echo "Deleted archives: ${deleted_count}"
``