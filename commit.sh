#!/bin/bash
# 📝 Quick Commit script
cd ~/docs

if [ -z "$1" ]; then
    echo -n "Enter commit message: "
    read -r msg
else
    msg="$1"
fi

if [ -z "$msg" ]; then
    echo "❌ Error: Commit message cannot be empty."
    exit 1
fi

git add .
git commit -m "$msg"
echo "✅ Changes committed locally! (Use 'sync' to push to GitHub)"
