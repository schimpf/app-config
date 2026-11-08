#!/usr/bin/env bash
# Usage: ./rotate.sh <slug>  — new code, new hash and date in <slug>/config.json, prints the code once.
source "$(dirname "$0")/lib.sh"
check_slug "${1:-}"
[[ -f "$1/config.json" ]] || { echo "no $1/config.json; use ./new-project.sh $1" >&2; exit 1; }
code=$(new_code)
write_config "$1" "$code"
print_code "$1" "$code"
