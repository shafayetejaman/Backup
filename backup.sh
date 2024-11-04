#!/bin/bash

# Use full paths for commands
GIT="/usr/bin/git"
SSH_ADD="/usr/bin/ssh-add"
SSH_AGENT="/usr/bin/ssh-agent"
REPO_DIR="/home/shafayet/Backup"   # Update with the absolute path to your repository
SSH_KEY="/home/shafayet/.ssh/id_ed25519"  # Update with the correct path to your SSH key
LOG_FILE="/home/shafayet/backup.log"  # Update with your desired log file location

# Redirect stdout and stderr to log file for debugging
exec > "$LOG_FILE" 2>&1


# Change to the repository directory
cd "$REPO_DIR" || { echo "Failed to change directory to $REPO_DIR"; exit 1; }

# Start SSH agent if it's not already running
export SSH_AUTH_SOCK="/tmp/ssh-auth-sock-$USER"

if [ ! -S "$SSH_AUTH_SOCK" ]; then
    eval "$($SSH_AGENT -s)"
fi

# Add the SSH key if not already added
if ! $SSH_ADD -l | grep -q 'id_ed25519'; then
    $SSH_ADD "$SSH_KEY"
    echo "SSH key added." >> LOG_FILE
fi

# Define a commit message
commit_message="Auto-commit on $(date +"%Y-%m-%d %H:%M:%S")"

# Check for changes
unstaged_changes=$($GIT diff --name-only)
untracked_files=$($GIT ls-files --others --exclude-standard)
staged_changes=$($GIT diff --name-only --cached)

if [[ -n "$unstaged_changes" || -n "$untracked_files" || -n "$staged_changes" ]]; then
    echo "Changes detected. Proceeding with Git push." >> LOG_FILE
    $GIT add .
    $GIT commit -m "$commit_message"
    $GIT push origin "$($GIT branch --show-current)"
    echo "Changes pushed successfully." >> LOG_FILE
else
    echo "No changes detected. Nothing to push." >> LOG_FILE
fi
