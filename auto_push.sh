#!/bin/bash
set -euo pipefail

read -p "Enter commit message: " msg

msg="${1:-Auto-update}"
git add .
git commit -m "$msg"
git push
