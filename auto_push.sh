#!/bin/bash
set -euo pipefail

msg="${1:-Auto-update}"
git add .
git commit -m "$msg"
git push
