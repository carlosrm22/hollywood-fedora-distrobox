#!/usr/bin/env bash
set -euo pipefail

src_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.local/bin" "$HOME/.bashrc.d" "$HOME/.local/share/fondo/widgets" "$HOME/.local/share/fondo/assets"
install -m 0755 "$src_dir/fondo" "$HOME/.local/bin/fondo"
install -m 0755 "$src_dir/fondo-hud" "$HOME/.local/bin/fondo-hud"
install -m 0755 "$src_dir/fondo-animate" "$HOME/.local/bin/fondo-animate"
install -m 0755 "$src_dir/fondo-widget-runner" "$HOME/.local/bin/fondo-widget-runner"

for w in "$src_dir"/widgets/*; do
  [ -f "$w" ] || continue
  install -m 0755 "$w" "$HOME/.local/share/fondo/widgets/$(basename "$w")"
done

# Optional compatibility launcher so old workflows keep working.
ln -sfn "$HOME/.local/bin/fondo" "$HOME/.local/bin/hollywood"

compat_file="$HOME/.bashrc.d/hollywood.sh"
install -m 0644 "$src_dir/hollywood.sh" "$compat_file"

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

echo "Installed commands: fondo, fondo-hud, fondo-animate, fondo-widget-runner"
echo "Installed widgets in: $HOME/.local/share/fondo/widgets"
echo "Compatibility: hollywood -> fondo"
echo "Run: hash -r && source ~/.bashrc"
