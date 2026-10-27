#!/bin/bash
set -euo pipefail

# Load OS information
if [ "$(uname -s)" = "Darwin" ]; then
	ID="macos"
elif [ -f /etc/os-release ]; then
	. /etc/os-release
fi

if [[ "${ID:-}" = "macos" ]]; then
    DESKTOP_PKGS=(
        dos2unix
        fastfetch
        htop
        inetutils
        ipython
        openssh
        python
        yazi
    )
    DESKTOP_CASKS=(
        firefox
        ghostty
        rectangle
        signal
        spotify
        syncthing-app
    )

    if command -v "brew" >/dev/null 2>&1; then
        brew install -y "${DESKTOP_PKGS[@]}"
        brew install -y --cask "${DESKTOP_CASKS[@]}"
    else
        echo "Error: brew not found. Please install 'brew' from the official documentation (or scripts/install-packges.sh)"
        exit 1
    fi
elif [[ "${ID:-}" = "arch" ]]; then
	DESKTOP_PKGS=(
        "firefox"
        "brightnessctl"
        "cronie"
        "dos2unix"
        "dracula-gtk-theme"
        "dunst"
        "fastfetch"
        "feh"
        "flameshot"
        "ghostty"
        "grim"
        "htop"
        "inetutils"
        "ipython"
        "man-db"
        "networkmanager"
        "noto-fonts-emoji"
        "nwg-look"
        "openssh"
        "playerctl"
        "python"
        "signal-desktop"
        "slurp"
        "spotify"
        "syncthing"
        "ttf-jetbrains-mono-nerd"
        "wiremix"
        "xdg-desktop-portal"
        "xdg-utils"
        "yazi"
        "zathura"
        "zathura-pdf-poppler"
	)

	HYPRLAND_PKGS=(
        "hyprland"
        "hyprlock"
        "hyprpaper"
        "hyprpicker"
        "rofi"
        "waybar"
        "wl-clipboard"
        "xdg-desktop-portal-hyprland"
	)

	if command -v "yay" >/dev/null 2>&1; then
		yay -Syu --noconfirm --needed "${DESKTOP_PKGS[@]}" "${HYPRLAND_PKGS[@]}"
	else
		echo "Error: yay not found. Please install 'yay' or 'yay-bin' from the AUR"
		exit 1
	fi
else
	echo "Only Arch and macOS are supported at this time for desktop installation"
	exit 1
fi
