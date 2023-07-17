#!/bin/bash
# Show env vars
grep -v '^#' .env
# Export env vars
set -o allexport
source .env
set +o allexport

eval "$(
  cat .env | awk '!/^\s*#/' | awk '!/^\s*$/' | while IFS='' read -r line; do
    key=$(echo "$line" | cut -d '=' -f 1)
    value=$(echo "$line" | cut -d '=' -f 2-)
    echo "echo \"$key=\"$value\"\""
  done
)" >> $GITHUB_ENV