#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

usage() {
    echo "Usage: $0 -u <username> -g <greeting>"
    exit 1
}

main() {
    echo "Welcome, $username, $greeting!"
}

while getopts ":u:g:" opt; do
  case $opt in
    u) username="$OPTARG" ;;
    g) greeting="$OPTARG" ;;
    *) usage ;;
  esac
done

if [ -z "${username:-}" ] || [ -z "${greeting:-}" ]; then
  usage
fi

main
