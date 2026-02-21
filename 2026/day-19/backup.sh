#!/usr/bin/env bash
set -euo pipefail

usage() { echo "Usage: $0 <source_dir> <backup_destination_dir>"; exit 1; }

SRC="${1:-}"
DEST="${2:-}"

[[ -z "$SRC" || -z "$DEST" ]] && usage

if [[ ! -d "$SRC" ]]; then
  echo "Error: source '$SRC' does not exist" >&2
  exit 2
fi

mkdir -p "$DEST"

DATE=$(date +%F)
ARCHIVE_NAME="backup-${DATE}.tar.gz"
ARCHIVE_PATH="${DEST%/}/${ARCHIVE_NAME}"

# Create archive of the source directory contents
tar -C "$SRC" -czf "$ARCHIVE_PATH" .

# Verify creation
if [[ -f "$ARCHIVE_PATH" ]]; then
  SIZE=$(du -h "$ARCHIVE_PATH" | awk '{print $1}')
  echo "Created: $ARCHIVE_PATH"
  echo "Size: $SIZE"
else
  echo "Error: archive creation failed" >&2
  exit 3
fi

# Delete backups older than 14 days
deleted_count=$(find "$DEST" -maxdepth 1 -type f -name "backup-*.tar.gz" -mtime +14 -print0 | tr -cd '\0' | wc -c || true)
if [[ "$deleted_count" -gt 0 ]]; then
  find "$DEST" -maxdepth 1 -type f -name "backup-*.tar.gz" -mtime +14 -print0 | xargs -0 rm -f
fi

echo "Old backups deleted: ${deleted_count}"
``