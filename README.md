# Hollywood on Fedora via Distrobox

Helpers for running the original `hollywood` package on Fedora using a Ubuntu Distrobox container.

## What this includes

- `hollywood.sh`: Bash functions and aliases for:
  - `hollywood`: run Hollywood in `hollywood-box`
  - `hollywood-classic` / `hclassic`: classic locale + default tuning (`-s 12 -d 10`)
  - `hollywood-bg` / `hbg`: launch in fullscreen terminal
  - `hollywood-bg-classic` / `hbgc`: fullscreen + classic mode
  - `hollywood-stop`: stop active Hollywood sessions
- `install.sh`: idempotent installer for `~/.bashrc.d/hollywood.sh`

## Requirements

- Fedora host with:
  - `podman`
  - `distrobox`
- A container named `hollywood-box` (Ubuntu 22.04 recommended)

## Setup

1. Install host dependencies:

```bash
sudo dnf install -y podman distrobox
```

2. Create container (once):

```bash
distrobox create -n hollywood-box -i ubuntu:22.04
```

3. Install Hollywood inside container (non-interactive):

```bash
distrobox enter hollywood-box -- bash -lc \
  "sudo env DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get update && \
   sudo env DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install -y hollywood"
```

4. Install shell helpers from this repo:

```bash
./install.sh
source ~/.bashrc
```

## Usage

- Normal:

```bash
hollywood
```

- Classic look:

```bash
hollywood-classic
```

- Fullscreen (graphical session):

```bash
hollywood-bg
```

- Fullscreen classic:

```bash
hollywood-bg-classic
```

- Stop stuck sessions:

```bash
hollywood-stop
```

## Notes

- This uses the original Ubuntu package (`hollywood` by Dustin Kirkland), not a clone.
- In text TTYs (`Ctrl+Alt+F3`, etc.) visuals differ from graphical terminals.
- If launched from an inaccessible directory, `distrobox enter` can fail; run from your home directory.
