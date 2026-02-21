# Shell helpers for running Hollywood from Fedora through Distrobox.
# Source this file from ~/.bashrc.

_hollywood_build_cmd() {
  local mode="${1:-default}"
  shift || true

  local -a cmd
  if command -v distrobox >/dev/null 2>&1; then
    cmd=(distrobox enter hollywood-box -- hollywood)
  elif command -v distrobox-host-exec >/dev/null 2>&1; then
    cmd=(distrobox-host-exec distrobox enter hollywood-box -- hollywood)
  else
    echo "No se encontro distrobox ni distrobox-host-exec en este shell." >&2
    return 127
  fi

  if [[ "$mode" == "classic" ]]; then
    cmd=(env LC_ALL=C LANG=C "${cmd[@]}" -s 12 -d 10)
  fi

  HOLLYWOOD_CMD=("${cmd[@]}" "$@")
}

hollywood() {
  _hollywood_build_cmd default "$@" || return $?
  "${HOLLYWOOD_CMD[@]}"
}

hollywood_classic() {
  _hollywood_build_cmd classic "$@" || return $?
  "${HOLLYWOOD_CMD[@]}"
}

_hollywood_launch_fullscreen() {
  local mode="${1:-default}"
  shift || true

  _hollywood_build_cmd "$mode" "$@" || return $?

  if [[ -z "${DISPLAY:-}" && -z "${WAYLAND_DISPLAY:-}" ]]; then
    "${HOLLYWOOD_CMD[@]}"
    return
  fi

  local cmd_str
  printf -v cmd_str '%q ' "${HOLLYWOOD_CMD[@]}"

  if command -v konsole >/dev/null 2>&1; then
    nohup konsole --fullscreen -e bash -lc "$cmd_str" >/dev/null 2>&1 &
  elif command -v gnome-terminal >/dev/null 2>&1; then
    nohup gnome-terminal --full-screen -- bash -lc "$cmd_str" >/dev/null 2>&1 &
  elif command -v xfce4-terminal >/dev/null 2>&1; then
    nohup xfce4-terminal --fullscreen -x bash -lc "$cmd_str" >/dev/null 2>&1 &
  elif command -v xterm >/dev/null 2>&1; then
    nohup xterm -maximized -e bash -lc "$cmd_str" >/dev/null 2>&1 &
  else
    echo "No se encontro un emulador de terminal para modo pantalla completa." >&2
    return 127
  fi
}

hollywood_bg() {
  _hollywood_launch_fullscreen default "$@"
}

hollywood_bg_classic() {
  _hollywood_launch_fullscreen classic "$@"
}

hollywood_stop() {
  pkill -f 'distrobox enter hollywood-box -- hollywood' >/dev/null 2>&1 || true
  pkill -f 'distrobox-host-exec distrobox enter hollywood-box -- hollywood' >/dev/null 2>&1 || true
  pkill -f 'attach-session -t hollywood' >/dev/null 2>&1 || true
  pkill -f 'new-session -d -s hollywood' >/dev/null 2>&1 || true
}

alias hollywood-bg='hollywood_bg'
alias hbg='hollywood_bg'
alias hollywood-classic='hollywood_classic'
alias hclassic='hollywood_classic'
alias hollywood-bg-classic='hollywood_bg_classic'
alias hbgc='hollywood_bg_classic'
alias hollywood-stop='hollywood_stop'
