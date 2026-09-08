#!/bin/bash
set -euo pipefail

# Load OS information
if [ -f /etc/os-release ]; then
	. /etc/os-release
fi

# Basic desktop check (can be improved based on preference)
IS_DESKTOP=false
if [[ -n "$DISPLAY" ]] || [[ -n "$WAYLAND_DISPLAY" ]]; then
	IS_DESKTOP=true
fi

if [ "$IS_DESKTOP" = true ] && [ "$ID" = "arch" ]; then
	DESKTOP_PKGS=(
		"brave-bin"
		"brightnessctl"
		"cronie"
		"dos2unix"
		"dracula-gtk-theme"
		"fastfetch"
		"feh"
		"ghostty"
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
		"spotify"
		"syncthing"
		"ttf-jetbrains-mono-nerd"
		"wiremix"
		"yazi"
		"zathura"
		"zathura-pdf-poppler"
	)

	HYPRLAND_PKGS=(
		"hyprland"
		"hyprpaper"
		"rofi"
		"waybar"
		"wl-clipboard"
		"xdg-desktop-portal-hyprland"
	)

	if command -v "yay" >/dev/null 2>&1; then
		yay -Sy --noconfirm --needed "${DESKTOP_PKGS[@]}" "${HYPRLAND_PKGS[@]}"
	else
		echo "Error: yay not found. Skipping desktop packages."
	fi
fi
