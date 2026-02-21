#!/usr/bin/env bash
set -euo pipefail

src_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="$HOME/.bashrc.d"
target_file="$target_dir/hollywood.sh"

mkdir -p "$target_dir"
cp "$src_dir/hollywood.sh" "$target_file"

if ! grep -q '^[[:space:]]*if \[ -d ~/.bashrc.d \]; then' "$HOME/.bashrc" 2>/dev/null; then
  cat >> "$HOME/.bashrc" <<'BASHRC_SNIPPET'

if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    [ -f "$rc" ] && . "$rc"
  done
  unset rc
fi
BASHRC_SNIPPET
fi

echo "Installed: $target_file"
echo "Run: source ~/.bashrc"
