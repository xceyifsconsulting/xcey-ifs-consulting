#!/bin/bash

# Specialized Script for Updating Pricing Page and Pushing to GitHub
# This script focuses specifically on pricing page updates for xcy-consulting website

set -e  # Exit on any error

echo "Starting Pricing Page Update and Push Process..."

# 1. Check if we're in the correct directory
if [ ! -d "/home/cbeew/.openclaw/workspace/xcy-consulting" ]; then
    echo "Error: Not in the xcy-consulting directory"
    exit 1
fi

cd /home/cbeew/.openclaw/workspace/xcy-consulting

# 2. Check if GitHub CLI is authenticated
echo "Checking GitHub authentication..."
if ! gh auth status > /dev/null 2>&1; then
    echo "Error: GitHub CLI not authenticated"
    echo "Please run: gh auth login"
    exit 1
fi

# 3. Find pricing-related files
echo "Locating pricing files..."
PRICING_FILES=$(find . -type f \( -name "*.html" -o -name "*.htm" \) -exec grep -l "pricing\|billing\|cost\|fee" {} \; 2>/dev/null | head -5)

if [ -z "$PRICING_FILES" ]; then
    echo "Warning: No pricing files found, checking for index.html"
    if [ -f "index.html" ]; then
        PRICING_FILES="index.html"
    else
        echo "Error: No pricing files found in the directory"
        exit 1
    fi
fi

echo "Found pricing files: $PRICING_FILES"

# 4. Create backup of existing files
echo "Creating backups..."
for file in $PRICING_FILES; do
    if [ -f "$file" ]; then
        cp "$file" "${file}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backup created: ${file}.backup.$(date +%Y%m%d_%H%M%S)"
    fi
done

# 5. Update files with new billing policy
echo "Updating pricing content..."
python3 pricing_updater.py

# 6. Commit changes
echo "Committing changes..."
git add .

# Check if there are changes to commit
if ! git diff --cached --quiet; then
    echo "Changes detected, committing..."
    git commit -m "Update pricing page: Completion-based billing policy"
else
    echo "No changes to commit"
    exit 0
fi

# 7. Push to remote repository
echo "Pushing to remote repository..."
gh repo push

echo "Pricing page update and push completed successfully!"
echo "New billing policy: 'we only charge once the work is complete'"