#!/bin/bash

# Simple backup script with rotation

function display_usage {
    echo "Usage: ./backup.sh <path to source> <path to backup folder> [max_backups]"
    echo "Example: ./backup.sh /data /backups 5"
}

if [ $# -lt 2 ]; then
    display_usage
    exit 1
fi

source_dir=$1
backup_dir=$2
max_backups=${3:-5}   # Default keep last 5 backups
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

function create_backup {
    mkdir -p "$backup_dir"
    archive="${backup_dir}/backup_${timestamp}.zip"
    zip -r "$archive" "$source_dir"
    echo "✅ Backup generated successfully: $archive"
}

function rotate_backups {
    total_backups=$(ls -1t "${backup_dir}"/backup_*.zip 2>/dev/null | wc -l)

    if [ "$total_backups" -gt "$max_backups" ]; then
        remove_count=$((total_backups - max_backups))
        old_backups=$(ls -1t "${backup_dir}"/backup_*.zip | tail -n "$remove_count")
        echo "♻️ Removing $remove_count old backup(s):"
        echo "$old_backups"
        rm -f $old_backups
    fi
}

create_backup
rotate_backups

