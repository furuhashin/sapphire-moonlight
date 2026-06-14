#!/usr/bin/env bash
# ============================================
# Theme Check: Shell / Bash
# ============================================
# - Shebang
# - Variables ($var, ${var}, $1, $@)
# - Command substitution $(...) / `...`
# - Strings (single / double)
# - Keywords (if, for, while, function, case)
# - Operators / Comparisons
# - Comments

set -euo pipefail

# --- Variables & constants ---
readonly MAX_RETRIES=3
GREETING="Hello, World!"
single='no $expansion here'
count=0

# --- Command substitution ---
current_dir="$(pwd)"
file_count=$(ls -1 | wc -l)
today=`date +%Y-%m-%d`

# --- Function definition ---
greet() {
  local name="${1:-stranger}"
  echo "Hello, ${name}! Today is ${today}."
}

retry() {
  local attempt=1
  while [[ $attempt -le $MAX_RETRIES ]]; do
    if "$@"; then
      return 0
    fi
    echo "Attempt ${attempt}/${MAX_RETRIES} failed" >&2
    ((attempt++))
  done
  return 1
}

# --- Conditionals ---
if [[ -d "$current_dir" && $file_count -gt 0 ]]; then
  echo "Directory has ${file_count} files"
elif [[ -z "${GREETING}" ]]; then
  echo "No greeting set"
else
  echo "Nothing to do"
fi

# --- Case statement ---
case "${1:-}" in
  start)
    echo "Starting..."
    ;;
  stop|halt)
    echo "Stopping..."
    ;;
  *)
    echo "Usage: $0 {start|stop}"
    exit 1
    ;;
esac

# --- Loops ---
for i in 1 2 3 4 5; do
  count=$((count + i))
done

for file in *.sh; do
  echo "Found: ${file}"
done

# --- Arrays ---
declare -a fruits=("apple" "banana" "cherry")
declare -A colors=([function]="#00e0e0" [type]="#ffd900")

echo "First fruit: ${fruits[0]}"
echo "Function color: ${colors[function]}"
echo "All fruits: ${fruits[@]}"

# --- Arithmetic & test ---
result=$((MAX_RETRIES * 2 + 1))
[[ $result -eq 7 ]] && echo "Math works"

greet "Alice"
