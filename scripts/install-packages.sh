#!/bin/bash
set -euo pipefail

# Load OS information
if [ "$(uname -s)" = "Darwin" ]; then
	ID="macos"
elif [ -f /etc/os-release ]; then
	. /etc/os-release
fi

install_brew() {
	if ! command -v brew >/dev/null 2>&1; then
        if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
            return 1
        fi
        # Temporarily add to path
        if [ -x /opt/homebrew/bin/brew ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
}

latest_github_release() {
	# Fall back to a known-good version if the API is unreachable or rate-limited.
	local repo="$1"
	local fallback="$2"
	local tag
	if ! tag=$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name'); then
		tag=""
	fi
	if [ -z "$tag" ] || [ "$tag" = "null" ]; then
		echo "Could not resolve latest ${repo} release; falling back to ${fallback}" >&2
		tag="$fallback"
	fi
	printf '%s\n' "$tag"
}

install_herdr() {
	local repo="herdrdev/herdr"
	local tag os arch
	case "$(uname -s)" in
		Linux) os="linux" ;;
		Darwin) os="macos" ;;
		*) echo "Unsupported OS for herdr: $(uname -s)" >&2; return 1 ;;
	esac
	case "$(uname -m)" in
		x86_64) arch="x86_64" ;;
		aarch64|arm64) arch="aarch64" ;;
		*) echo "Unsupported architecture for herdr: $(uname -m)" >&2; return 1 ;;
	esac
	tag=$(latest_github_release "$repo" "v0.9.5")
	mkdir -p "$HOME/.local/bin"
	curl -fsSL -o "$HOME/.local/bin/herdr" \
		"https://github.com/${repo}/releases/download/${tag}/herdr-${os}-${arch}"
	chmod u+x "$HOME/.local/bin/herdr"
}

install_nvim() {
	local repo="neovim/neovim-releases"
	local tag
	tag=$(latest_github_release "$repo" "v0.12.1")
	mkdir -p "$HOME/.local/bin"
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


install_yay() {
    # OS specific config
    if [ "${ID:-}" = "arch" ]; then
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
    else
        echo "yay installation only supported on Arch"
        return 1
    fi
}

if [ "${ID:-}" = "macos" ]; then
	install_brew

	PKGS=(
		curl
		fzf
		git
        herdr
		jq
		neovim
		openssh
		tree-sitter-cli
		pass
		rsync
		zsh
	)
	brew install -y "${PKGS[@]}"

elif [ "${ID:-}" = "arch" ]; then
    install_yay
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
		zsh
	)
	yay -Sy --noconfirm --needed "${PKGS[@]}"
	install_herdr

elif [ "${ID:-}" = "debian" ] || [ "${ID:-}" = "ubuntu" ]; then
	PKGS=(
		cron
		curl
		gcc
		git
		jq
		pass
		rsync
		software-properties-common
		tree-sitter-cli
		zsh
	)
	sudo apt update && sudo apt install -y "${PKGS[@]}"

	# Add custom PPAs
	sudo add-apt-repository ppa:neovim-ppa/unstable
	# Install PPA packages
	sudo apt update && sudo apt install -y neovim

	install_fzf
	install_herdr

elif [ "${ID:-}" = "ol" ]; then
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
	install_herdr
	cargo install tree-sitter-cli
fi
