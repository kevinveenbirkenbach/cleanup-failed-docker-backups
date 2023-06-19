#!/bin/bash

# Define backup hash argument as BACKUP_HASH
BACKUP_HASH="$1"

# Define main directory containing subdirectories to potentially be deleted
MAIN_DIRECTORY="Backups/$BACKUP_HASH/docker-volume-backup/"

# Define trigger directory argument as TRIGGER_DIR
TRIGGER_DIR="$2"

# Loop through all subdirectories in the main directory
for SUBDIR in "$MAIN_DIRECTORY"/*; do

    # Only proceed if it is a directory
    if [ -d "$SUBDIR" ]; then

        # Only proceed if the subdirectory name matches a date-time-stamp format (YYYY-MM-DDTHH:MM:SS)
        if [[ $(basename "$SUBDIR") =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then

            # Only proceed if the specified trigger directory does not exist within the subdirectory
            if [ ! -d "$SUBDIR/$TRIGGER_DIR" ]; then
                # Display the subdirectory contents
                echo "Contents of subdirectory: $SUBDIR"
                ls "$SUBDIR"
                
                # Ask for user confirmation before deletion
                read -p "Are you sure you want to delete this subdirectory? (y/n) " -n 1 -r
                echo    # move to a new line
                if [[ $REPLY =~ ^[Yy]$ ]]
                then
                    # Notify the user of the deletion, then delete the subdirectory
                    echo "Deleting subdirectory: $SUBDIR"
                    rm -rf "$SUBDIR"
                fi
            fi
        fi
    fi
done
