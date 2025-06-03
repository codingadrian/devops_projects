#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Default values
BUILD_DIR="site"
DEPLOY_BRANCH="gh-pages"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

usage() {
  echo "Usage: $0 [-b <branch>] [-d <directory>]"
  exit 1
}

parse_args() {
  while getopts ":b:d:" opt; do
    case $opt in
      b) DEPLOY_BRANCH="$OPTARG" ;;
      d) BUILD_DIR="$OPTARG" ;;
      *) usage ;;
    esac
  done
}

check_prerequisites() {
  if [ ! -d "$BUILD_DIR" ]; then
    log "❌ Build directory '$BUILD_DIR' not found."
    exit 1
  fi
}

deploy() {
  CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
  log "Saving current branch: $CURRENT_BRANCH"

  git checkout --orphan "$DEPLOY_BRANCH" 2>/dev/null || git checkout "$DEPLOY_BRANCH"
  git rm -rf . > /dev/null 2>&1 || true
  cp -r "$BUILD_DIR"/* .
  git add .
  git commit -m "🚀 Deploy on $(date)"
  git push -f origin "$DEPLOY_BRANCH"
  log "✅ Deployment complete."

  git checkout "$CURRENT_BRANCH"
}

main() {
  parse_args "$@"
  check_prerequisites
  deploy
}

main "$@"
