# Shared helpers for new-project.sh and rotate.sh. Never writes the plaintext code to disk.
set -euo pipefail
cd "$(dirname "$0")"
OWNER=schimpf
BASE="https://$OWNER.github.io/app-config"

check_slug() {
  [[ "${1:-}" =~ ^[a-z0-9][a-z0-9-]{0,63}$ ]] || { echo "usage: $0 <slug> (lowercase, digits, dashes)" >&2; exit 1; }
}

# REVIEW-XXXX-XXXX-XXXX-XXXX: 16 chars from a 32-letter alphabet = 80 bits, from the OS CSPRNG.
new_code() {
  python3 -I -c 'import secrets
a = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
c = "".join(secrets.choice(a) for _ in range(16))
print("REVIEW-" + "-".join(c[i:i+4] for i in range(0, 16, 4)))'
}

# Same rule as the apps: uppercase, drop spaces and dashes, SHA-256 lowercase hex.
code_hash() {
  printf '%s' "$1" | tr -d ' -' | tr '[:lower:]' '[:upper:]' | sha256sum | cut -d' ' -f1
}

write_config() {  # slug code
  cat > "$1/config.json" <<JSON
{
  "reviewer_code_hash": "$(code_hash "$2")",
  "reviewer_code_enabled": true,
  "updated": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
JSON
}

print_code() {  # slug code
  printf '%s\t%s\t%s\n' "$1" "$2" "$BASE/$1/config.json"
}
