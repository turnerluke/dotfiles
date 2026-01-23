#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Packages available on all platforms
COMMON_PACKAGES=(
    bash
    claude
    lazygit
    nvim
    starship
    tmux
    zsh
)

# Terminal emulators (pick what you use)
TERMINAL_PACKAGES=(
    alacritty
    ghostty
    kitty
)

# Linux-only packages (window managers, bars, etc.)
LINUX_PACKAGES=(
    backgrounds
    dwm
    gnome
    hyprland
    picom
    polybar
    rofi
    swaync
    waybar
    wlogout
    wofi
)

log_info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

detect_os() {
    case "$OSTYPE" in
        darwin*)  echo "macos" ;;
        linux*)   echo "linux" ;;
        msys*|cygwin*|win32*) echo "windows" ;;
        *)        echo "unknown" ;;
    esac
}

detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "${ID:-unknown}"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    elif [[ -f /etc/debian_version ]]; then
        echo "debian"
    elif [[ -f /etc/redhat-release ]]; then
        echo "rhel"
    else
        echo "unknown"
    fi
}

check_stow() {
    if command -v stow &> /dev/null; then
        return 0
    fi

    log_error "GNU Stow is not installed"

    local os=$(detect_os)
    if [[ "$os" == "macos" ]]; then
        echo "  Install with: brew install stow"
    elif [[ "$os" == "linux" ]]; then
        local distro=$(detect_distro)
        case "$distro" in
            arch|manjaro|endeavouros)
                echo "  Install with: sudo pacman -S stow" ;;
            ubuntu|debian|pop|linuxmint)
                echo "  Install with: sudo apt install stow" ;;
            fedora)
                echo "  Install with: sudo dnf install stow" ;;
            rhel|centos|rocky|alma)
                echo "  Install with: sudo yum install stow" ;;
            opensuse*|suse*)
                echo "  Install with: sudo zypper install stow" ;;
            alpine)
                echo "  Install with: sudo apk add stow" ;;
            nixos)
                echo "  Install with: nix-env -iA nixpkgs.stow" ;;
            void)
                echo "  Install with: sudo xbps-install stow" ;;
            gentoo)
                echo "  Install with: sudo emerge app-admin/stow" ;;
            *)
                echo "  Install stow using your package manager" ;;
        esac
    else
        echo "  Install stow using your package manager"
    fi
    exit 1
}

stow_package() {
    local pkg="$1"
    if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
        log_info "Stowing $pkg..."
        stow -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
    else
        log_warn "Package '$pkg' not found, skipping"
    fi
}

unstow_package() {
    local pkg="$1"
    if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
        log_info "Unstowing $pkg..."
        stow -d "$DOTFILES_DIR" -t "$HOME" -D "$pkg"
    fi
}

install_common() {
    log_info "Installing common packages..."
    for pkg in "${COMMON_PACKAGES[@]}"; do
        stow_package "$pkg"
    done
}

install_terminals() {
    log_info "Installing terminal emulators..."
    for pkg in "${TERMINAL_PACKAGES[@]}"; do
        stow_package "$pkg"
    done
}

install_linux() {
    local os=$(detect_os)
    if [[ "$os" == "linux" ]]; then
        log_info "Installing Linux-specific packages..."
        for pkg in "${LINUX_PACKAGES[@]}"; do
            stow_package "$pkg"
        done
    else
        log_warn "Skipping Linux packages (detected OS: $os)"
    fi
}

install_all() {
    install_common
    install_terminals
    install_linux
}

uninstall_all() {
    log_info "Removing all symlinks..."
    for pkg in "${COMMON_PACKAGES[@]}" "${TERMINAL_PACKAGES[@]}" "${LINUX_PACKAGES[@]}"; do
        unstow_package "$pkg"
    done
}

usage() {
    local os=$(detect_os)
    local distro=""
    [[ "$os" == "linux" ]] && distro=" ($(detect_distro))"

    cat << EOF
Usage: $(basename "$0") [OPTION] [PACKAGES...]

Detected: ${os}${distro}

Options:
    -a, --all         Install all packages (platform-aware)
    -c, --common      Install common packages only
    -t, --terminals   Install terminal emulators
    -l, --linux       Install Linux-specific packages
    -u, --uninstall   Remove all symlinks
    -h, --help        Show this help message

Examples:
    $(basename "$0") --all              # Install everything
    $(basename "$0") --common           # Just the essentials
    $(basename "$0") nvim tmux zsh      # Install specific packages
    $(basename "$0") --uninstall        # Remove all symlinks
EOF
}

main() {
    check_stow
    cd "$DOTFILES_DIR"

    if [[ $# -eq 0 ]]; then
        usage
        exit 0
    fi

    case "${1:-}" in
        -a|--all)       install_all ;;
        -c|--common)    install_common ;;
        -t|--terminals) install_terminals ;;
        -l|--linux)     install_linux ;;
        -u|--uninstall) uninstall_all ;;
        -h|--help)      usage ;;
        -*)             log_error "Unknown option: $1"; usage; exit 1 ;;
        *)
            # Install specific packages passed as arguments
            for pkg in "$@"; do
                stow_package "$pkg"
            done
            ;;
    esac

    log_info "Done!"
}

main "$@"
