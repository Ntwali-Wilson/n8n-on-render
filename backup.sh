#!/bin/bash

cd /home/node/n8n-backup

git config user.name "n8n-bot"
git config user.email "bot@n8n.local"

git pull origin master

git add .
git commit -m "n8n backup $(date +%Y-%m-%d_%H-%M-%S)" || echo "No changes to commit"
git push -f origin master
