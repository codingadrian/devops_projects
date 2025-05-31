#!/bin/bash
set -euo pipefail

BUILD_DIR="site"
DEPLOY_BRANCH="gh-pages"

# Check if build directoy exists
if [ ! -d "$BUILD_DIR" ]; then
  echo "X Build directory $BUILD_DIR does not exist."
  exit 1
fi

# Save current branch
CURRENT_BRANCH=$(git symbolic-ref --short HEAD)

# Create orphan branch
git checkout --orphan $DEPLOY_BRANCH

#Remove everything from the new branch
git rm -rf . > /dev/null 2>&1 || true

# Copy site content to root
cp -r $BUILD_DIR/* .

# Commit and push
git add .
git commit -m "Deploy to GitHub Pages"
git push -f origin $DEPLOY_BRANCH

# Return to main
git checkout "$CURRENT_BRANCH"
