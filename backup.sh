#!/bin/bash
backup_src="/home/wicky/my_files/"
backup_dest="/mnt/backup/current"
current_date=$(date +%Y-%m-%d)
log_path="/mnt/backup/logs"
previous_files="/mnt/backup/files_previous/$current_date"

#Safety Check
if ! mountpoint -q /mnt/backup; then
   echo "Backup directory  is not mounted,Exiting!!"
   exit 1
fi
# Create required directories
mkdir -p "$log_path"
mkdir -p "$previous_files"

# Run rsync safely without wiping log/backup folders
rsync -av --delete \
  --exclude="logs" \
  --exclude="files_previous" \
  --backup --backup-dir="$previous_files" \
  "$backup_src" "$backup_dest" \
  >"$log_path/backup_$current_date.log" \
  2>"$log_path/backup_${current_date}_error.log"
