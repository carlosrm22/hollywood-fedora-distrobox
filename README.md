# Fondo Dashboard (native Hollywood-style)

This repository ships a native `tmux` dashboard called `fondo`.

## What you get

- Your base panels: `btop`, `procs`, `duf`, `fastfetch`, `cmatrix`
- Plus one rotating pane with original Hollywood-style widgets
- Motion effects: layout rotation + pane shuffling
- No `distrobox` required

## Original Hollywood widgets integrated

`apg`, `atop`, `bmon`, `cmatrix`, `code`, `errno`, `hexdump`, `htop`, `jp2a`, `logs`, `man`, `map`, `mplayer`, `speedometer`, `sshart`, `stat`, `tree`

Each widget is installed as an executable script in:
`~/.local/share/fondo/widgets`

Only available widgets run (dependency-aware checks).

## Install

```bash
./install.sh
hash -r
fondo
```

## Runtime options

```bash
FONDO_LAYOUT_INTERVAL=5 fondo        # faster motion
FONDO_MOTION=0 fondo                 # static layout
FONDO_WIDGET_DURATION=24 fondo       # longer widget display time
```

## Keys inside tmux

- `Ctrl+b q`: kill `fondo`
- `Ctrl+b l`: next layout
- `Ctrl+b r`: rotate panes

## Compatibility

`hollywood` command still works and now points to `fondo`.
