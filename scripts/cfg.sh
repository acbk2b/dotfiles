#! /bin/bash

CFG=(git --git-dir="$HOME/.cfg/" --work-tree="$HOME")

cfg() {
	"${CFG[@]}" "$@"
}

if [[ ! -d "$HOME/.cfg" ]]; then
	DOTFILE_REPO="https://gitlab.com/acbk2b/dotfiles.git"
	git clone --bare "$DOTFILE_REPO" "$HOME/.cfg"

	# Back up existing dotfiles
	mkdir -p .config-backup &&
		cfg checkout 2>&1 | grep -E "^\s+.*" | awk '{print $1}' |
		while read -r file; do
			mkdir -p "$HOME/.config-backup/$(dirname "$file")"
			mv "$HOME/$file" "$HOME/.config-backup/$file"
		done

	# Deploy dotfiles
	cfg checkout
	cfg config --local status.showUntrackedFiles no
fi
