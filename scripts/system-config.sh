#!/bin/bash
set -euo pipefail

# Load OS information
if [ -f /etc/os-release ]; then
	. /etc/os-release
fi

# General system config
REPOS_DIR="$HOME/repos"
mkdir -p "$REPOS_DIR"

TPM_DIR="$HOME/.tmux/plugins/tpm"

# Install tmux tpm plugin manager if missing
if [[ ! -d "$TPM_DIR" ]]; then
	git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
fi

# OS specific config
if [ "$ID" = "arch" ]; then
	# install yay
	if ! command -v "yay" >/dev/null 2>&1; then
		git clone https://aur.archlinux.org/yay-bin.git "${REPOS_DIR}/yay-bin"
		cd "${REPOS_DIR}/yay-bin"
		makepkg -si --noconfirm
		cd -
	fi

	# pacman config updates
	sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf
	sudo sed -i 's/#Color/Color/' /etc/pacman.conf
fi

# Set ~/.gitconfig options
# misc opts
git config --global push.autoSetupRemove true
git config --global init.defaultBranch main
# nvim diff view
git config --global diff.tool nvimdiff
git config --global difftool.prompt false
git config --global difftool.nvimdiff.cmd 'nvim -d "$LOCAL" "$REMOTE"'
