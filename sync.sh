#!/bin/bash
# 🔄 Sync changes to GitHub
cd ~/docs
git add .
git commit -m "Update configs & docs: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin master
echo "✅ Changes pushed to GitHub!"
