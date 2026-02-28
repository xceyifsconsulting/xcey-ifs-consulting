#!/bin/bash

# 1. Stage changes
git add .

# 2. Commit changes (using a simple default message if none is provided)
git commit -m "Update from Ubuntu: $(date)"

# 3. Pull latest changes first
git pull origin main --rebase

# 4. Push to GitHub
git push origin main
