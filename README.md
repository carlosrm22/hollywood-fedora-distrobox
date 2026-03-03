# Fondo Dashboard (native Hollywood-style)

This repository ships a native `tmux` dashboard called `fondo`.

## What you get

- Six-pane dashboard with rotating mixes and live telemetry
- Your base panel stack: `btop`, `procs`, `duf`, `fastfetch`, `cmatrix`
- Barracuda monitoring (`upsilon-readings`) with higher presence
- Original Hollywood widgets + extra visual widgets
- Motion effects: layout rotation + pane shuffling
- No `distrobox` required

## Widgets integrated

Original set:
`apg`, `atop`, `bmon`, `cmatrix`, `code`, `errno`, `hexdump`, `htop`, `jp2a`, `logs`, `man`, `map`, `mplayer`, `speedometer`, `sshart`, `stat`, `tree`

Extra visual set:
`cava`, `lavat` (fallbacks to `cmatrix` if missing), `gtop` (fallbacks to `procs` if missing), `nyancat`, `asciiquarium`, `cbonsai`, `peaclock`

Each widget is installed as an executable script in:
`~/.local/share/fondo/widgets`

Only available widgets run (`--check` dependency-aware).

## Install

```bash
./install.sh
hash -r
fondo
```

## Runtime options

```bash
FONDO_LAYOUT_INTERVAL=5 fondo          # faster motion
FONDO_MOTION=0 fondo                   # static layout
FONDO_WIDGET_DURATION=24 fondo         # longer widget display time
FONDO_MAP_MIN_COLS=72 fondo            # show map only on larger panes
FONDO_MPLAYER_MAX_SECS=3 fondo         # reduce mplayer exposure
```

## Keys inside tmux

- `Ctrl+b q`: kill `fondo`
- `Ctrl+b l`: normalize layout
- `Ctrl+b r`: restore default readable layout
- `Ctrl+b R`: shuffle panes

## Compatibility

`hollywood` command still works and now points to `fondo`.
