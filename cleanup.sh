#!/bin/bash

# Define backup hash argument as BACKUP_HASH
BACKUP_HASH="$1"

# Define main directory containing subdirectories to potentially be deleted
MAIN_DIRECTORY="/Backups/$BACKUP_HASH/backup-docker-to-local"
if [ -d "$MAIN_DIRECTORY" ]; then
    echo "Cleaning up directory: $MAIN_DIRECTORY"
else 
    echo "Error: $MAIN_DIRECTORY does not exist."
    exit 1
fi

# Define trigger directory argument as TRIGGER_DIR
TRIGGER_DIR="$2"

# Loop through all subdirectories in the main directory
for SUBDIR in "$MAIN_DIRECTORY"/*; do

    # Only proceed if it is a directory
    if [ -d "$SUBDIR" ]; then
            echo "Validating directory: $SUBDIR"
            # Only proceed if the specified trigger directory does not exist within the subdirectory
            FULL_TRIGGER_DIR_PATH="$SUBDIR/$TRIGGER_DIR"
            if [ ! -d "$FULL_TRIGGER_DIR_PATH" ]; then
                echo "Validation: error"
                echo "Missing directory: $FULL_TRIGGER_DIR_PATH"
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
                    rm -vrf "$SUBDIR"
                fi
            else
                echo "Validation: ok"
                echo "$SUBDIR contains $FULL_TRIGGER_DIR_PATH."
            fi
    fi
done
