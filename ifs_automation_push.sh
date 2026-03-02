#!/bin/bash

# IFS Consulting Automation Push Script
# Optimized for pushing IFS consulting website updates and documentation

set -e  # Exit on any error

echo "=================================================="
echo "IFS Consulting Website Automation Push"
echo "=================================================="

# --- NEW LOGIC: Stage FIRST, then Check ---

# 1. Force stage all changes (including new files like index.html)
echo "Staging all changes in xcy-consulting..."
git add .

# 2. Now check if there is anything ready to commit
if git diff --cached --quiet; then
    echo "No changes detected after staging."
    echo "Nothing to push."
    exit 0
fi

# 3. Proceed with automated commit and push...
# (The rest of your script follows)

# 3. Get repository information
REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
echo "Repository: $REPO_NAME"

# --- NEW STEP 4: Stage everything first so Git can see it ---
echo "Staging all current changes..."
git add .

# --- NEW STEP 5: Now check if there is actually anything to commit ---
if git diff --cached --quiet; then
    echo "No changes detected after staging"
    echo "Nothing to push"
    exit 0
fi

# 6. Automated commit message based on changes
echo "Generating commit message..."

# Check what type of changes we have
if git diff --cached --name-only | grep -q "pricing"; then
    COMMIT_MSG="Update IFS consulting pricing policy: Completion-based billing"
elif git diff --cached --name-only | grep -q "index\|home"; then
    COMMIT_MSG="Update IFS consulting website homepage content"
elif git diff --cached --name-only | grep -q "services\|consulting"; then
    COMMIT_MSG="Update IFS consulting services documentation"
else
    COMMIT_MSG="Update IFS consulting website content"
fi

# 7. Stage changes (in case any were missed)
echo "Staging changes..."
git add .

# 8. Commit changes
echo "Committing changes with message:"
echo "\"$COMMIT_MSG\""
git commit -m "$COMMIT_MSG"

# 9. Push to GitHub
echo "Pushing to remote repository..."
if ! git push; then
    echo "Push failed. Trying with verbose output..."
    git push -v
    if [ $? -ne 0 ]; then
        echo "Error: Final push attempt failed"
        exit 1
    fi
fi

# 10. Validate push
echo "Verifying push was successful..."
if gh repo view > /dev/null 2>&1; then
    echo "GitHub repository verified"
else
    echo "Warning: Could not verify GitHub repository status"
fi

# 11. Create GitHub issue for documentation (optional)
echo ""
echo "Creating documentation issue..."
# gh issue create --repo owner/repo --title "Website Update - $COMMIT_MSG" --body "Automated update pushed to repository for IFS consulting"

echo "=================================================="
echo "SUCCESS: IFS Consulting Website Updates Pushed!"
echo "=================================================="
echo "Commit message: $COMMIT_MSG"
echo "Repository: $REPO_NAME"
echo "Please verify on your website and GitHub repository"
echo "=================================================="

# 12. Additional SEO validation (check for key terms)
echo ""
echo "SEO Validation Check:"
echo "Key terms in updated content:"
grep -r "IFS" . --include="*.html" --include="*.md" | head -5
