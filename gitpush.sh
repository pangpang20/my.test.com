#!/bin/bash
# Set default value for commit_commont if not provided
commit_commont="${1:-update codes and docs}"

# Run pre-commit hooks on all files
pre-commit run --all-files
pre-commit run --all-files

# Add changes to the staging area
git add .

# Commit the changes with the provided or default message
git commit -m "$commit_commont"

# Push the changes to the main branch
git push origin main
