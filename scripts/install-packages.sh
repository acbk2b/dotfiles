#!/bin/bash
set -euo pipefail

# Load OS information
if [ -f /etc/os-release ]; then
	. /etc/os-release
fi

install_nvim() {
	# Resolve the latest release tag from the GitHub API, falling back to a
	# known-good version if the API is unreachable or rate-limited.
	local repo="neovim/neovim-releases"
	local fallback="v0.12.1"
	local tag
	tag=$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name')
	if [ -z "$tag" ] || [ "$tag" = "null" ]; then
		echo "Could not resolve latest nvim release; falling back to ${fallback}" >&2
		tag="$fallback"
	fi

	curl -fsSL -o ~/.local/bin/nvim \
		"https://github.com/${repo}/releases/download/${tag}/nvim-linux-x86_64.appimage"
	chmod u+x ~/.local/bin/nvim
}

install_fzf() {
	if command -v "go" >/dev/null 2>&1; then
		go install github.com/junegunn/fzf@latest
	else
		echo "Please install 'go' to install fzf!"
	fi
}

if [ "$ID" = "arch" ]; then
	PKGS=(
		curl
		fzf
		git
		jq
		neovim
		openssh
		tree-sitter-cli
		pass
		rsync
		tmux
		zsh
	)
	sudo pacman -Sy --noconfirm --needed "${PKGS[@]}"

elif [ "$ID" = "debian" ] || [ "$ID" = "ubuntu" ]; then
	PKGS=(
		cron
		curl
		gcc
		git
		jq
		pass
		rsync
		software-properties-common
		tmux
		tree-sitter-cli
		zsh
	)
	sudo apt update && sudo apt install -y "${PKGS[@]}"

	# Add custom PPAs
	sudo add-apt-repository ppa:neovim-ppa/unstable
	# Install PPA packages
	sudo apt update && sudo apt install -y neovim

	install_fzf

elif [ "$ID" = "ol" ]; then
	PKGS=(
		cargo
		cronie
		curl
		gcc
		gcc-c++
		git
		jq
		make
		pass
		rsync
		rust
		zsh
	)
	sudo dnf update -y && sudo dnf install -y "${PKGS[@]}"

	install_fzf
	install_nvim
	cargo install tree-sitter-cli
fi
