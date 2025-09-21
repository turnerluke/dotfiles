# DWM Configuration

Custom DWM build with centered master layout.

## Features

- **Centered Master Layout**: `Super+c` - Master window centered with stack windows alternating left/right
- **Custom Terminal**: Uses Ghostty instead of st
- **Multi-Monitor Support**: Optimized for ultrawide + laptop setup
- **120Hz Refresh Rate**: Configured for high refresh displays

## Layouts

- `Super+t`: Tiled layout (default)
- `Super+c`: **Centered master** - Master centered, stack alternates sides
- `Super+f`: Floating layout
- `Super+m`: Monocle (fullscreen)

## Key Bindings

- `Super+Return`: Open terminal (Ghostty)
- `Super+r`: dmenu launcher
- `Super+d`: rofi launcher
- `Super+q`: Close window
- `Super+Shift+q`: Quit DWM

## Installation

```bash
cd suckless/dwm
make clean && make
sudo make install
```

## Monitor Setup

Monitor configuration is handled in `~/.xprofile`:

- DP-1 (ultrawide): 3840x1080 @ 120Hz, primary
- eDP-1 (laptop): 1920x1080 @ 60Hz, positioned right

## Custom Modifications

- Added `centeredmaster()` function for alternating stack layout
- Modified terminal command to use Ghostty
- Updated keybindings for new layout

