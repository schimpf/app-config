#!/usr/bin/env bash
# Usage: ./new-project.sh <slug>  — creates <slug>/config.json and prints the code once.
source "$(dirname "$0")/lib.sh"
check_slug "${1:-}"
[[ -e "$1" ]] && { echo "$1 already exists; use ./rotate.sh $1" >&2; exit 1; }
mkdir "$1"
code=$(new_code)
write_config "$1" "$code"
print_code "$1" "$code"
