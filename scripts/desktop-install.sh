#!/bin/bash
set -euo pipefail

# Load OS information
if [ -f /etc/os-release ]; then
	. /etc/os-release
fi

if [[ "${ID:-}" = "arch" ]]; then
	DESKTOP_PKGS=(
        "brave-bin"
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
        "newsboat"
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
		echo "Error: yay not found. Skipping desktop packages."
		exit 1
	fi
else
	echo "Only Arch is supported at this time for desktop installation"
	exit 1
fi
