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

# Return 0 (and say so) if <name> is already on PATH, so callers can skip.
already_installed() {
	if command -v "$1" >/dev/null 2>&1; then
		echo "$1 already installed at $(command -v "$1"); skipping"
		return 0
	fi
	return 1
}

# Download a single-file binary into ~/.local/bin/<name>.
# Downloads beside the target, then renames over it: writing directly fails
# with ETXTBSY (curl error 23) while the binary is running; mv swaps it safely.
install_binary() {
	local url="$1"
	local name="$2"
	local install_dir="$HOME/.local/bin"
	mkdir -p "$install_dir"
	local tmp
	tmp=$(mktemp "${install_dir}/.${name}.XXXXXX")
	if curl -fsSL -o "$tmp" "$url"; then
		chmod u+x "$tmp"
		mv -f "$tmp" "${install_dir}/${name}"
	else
		rm -f "$tmp"
		return 1
	fi
}

install_herdr() {
	# Linux x86_64 only; macOS gets herdr from brew.
	already_installed herdr && return 0
	local repo="herdrdev/herdr"
	local tag
	tag=$(latest_github_release "$repo" "v0.9.5")
	install_binary \
		"https://github.com/${repo}/releases/download/${tag}/herdr-linux-x86_64" \
		herdr
}

install_nvim() {
	already_installed nvim && return 0
	local repo="neovim/neovim-releases"
	local tag
	tag=$(latest_github_release "$repo" "v0.12.1")
	install_binary \
		"https://github.com/${repo}/releases/download/${tag}/nvim-linux-x86_64.appimage" \
		nvim
}

install_fzf() {
	already_installed fzf && return 0
	local repo="junegunn/fzf"
	local tag
	tag=$(latest_github_release "$repo" "v0.74.5")
	# Tags are "vX.Y.Z" but asset names omit the "v".
	local version="${tag#v}"
	local install_dir="$HOME/.local/bin"
	mkdir -p "$install_dir"

	# Asset is a tarball containing the fzf binary; extract it in place.
	if curl -fsSL \
		"https://github.com/${repo}/releases/download/${tag}/fzf-${version}-linux_amd64.tar.gz" \
		| tar -xz -C "$install_dir" fzf; then
		chmod u+x "${install_dir}/fzf"
	elif command -v "go" >/dev/null 2>&1; then
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
		fd
		fzf
		git
        herdr
		jq
		neovim
		openssh
		tree-sitter-cli
		pass
		ripgrep
		rsync
		zsh
	)
	brew install "${PKGS[@]}"

elif [ "${ID:-}" = "arch" ]; then
    install_yay
	PKGS=(
		curl
		fd
		fzf
		git
		jq
		neovim
		openssh
		tree-sitter-cli
		pass
		ripgrep
		rsync
		zsh
	)
	yay -Sy --noconfirm --needed "${PKGS[@]}"
	install_herdr

elif [ "${ID:-}" = "debian" ] || [ "${ID:-}" = "ubuntu" ]; then
	PKGS=(
		cron
		curl
		fd-find
		gcc
		git
		jq
		pass
		ripgrep
		rsync
		software-properties-common
		tree-sitter-cli
		zsh
	)
	sudo apt update && sudo apt install -y "${PKGS[@]}"

	# Debian ships fd as "fdfind" -> rename to  "fd" in .local/bin
	mkdir -p "$HOME/.local/bin"
	ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"

	# Add custom PPAs
	sudo add-apt-repository ppa:neovim-ppa/unstable
	# Install PPA packages
	sudo apt update && sudo apt install -y neovim

	install_fzf
	install_herdr

elif [ "${ID:-}" = "ol" ] || [ "${ID:-}" = "rhel" ]; then
	# EPEL provides fd-find, fzf, pass, ripgrep, and tree-sitter-cli.
	# VERSION_ID contains full verison (e.g. 9.4) -> repo names only use the major version.
	EL_MAJOR="${VERSION_ID%%.*}"
	if [ "${ID}" = "ol" ]; then
		# The release package adds the EPEL repo already enabled.
		sudo dnf install -y "oracle-epel-release-el${EL_MAJOR}"
	else
		# EPEL packages depend on CodeReady Builder (CRB) on RHEL.
		sudo subscription-manager repos --enable "codeready-builder-for-rhel-${EL_MAJOR}-$(arch)-rpms"
		sudo dnf install -y "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${EL_MAJOR}.noarch.rpm"
	fi

	PKGS=(
		cronie
		curl
		fd-find
		fzf
		gcc
		gcc-c++
		git
		jq
		make
		pass
		ripgrep
		rsync
		tree-sitter-cli
		zsh
	)
	sudo dnf update -y && sudo dnf install -y "${PKGS[@]}"

	# EPEL's neovim (0.8) is too old.
	install_nvim
	install_herdr
fi
