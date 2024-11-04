#!/bin/bash

# Define a commit message (you can modify it to include a timestamp or other details)
commit_message="Auto-commit on $(date +"%Y-%m-%d %H:%M:%S")"

# Check for unstaged changes
unstaged_changes=$(git diff --name-only)

# Check for untracked files
untracked_files=$(git ls-files --others --exclude-standard)

# Check for staged but uncommitted changes
staged_changes=$(git diff --name-only --cached)

# If there are any changes (unstaged, untracked, or staged), then proceed
if [[ -n "$unstaged_changes" || -n "$untracked_files" || -n "$staged_changes" ]]; then
  echo "Changes detected. Proceeding with Git push."

  # Stage all changes
  git add .

  # Commit the changes
  git commit -m "$commit_message"

  # Push to the remote repository
  git push origin "$(git branch --show-current)"

  echo "Changes pushed successfully."

fi
