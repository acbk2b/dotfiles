# dotfiles

My personal `dotfiles`, managed using the [Atlassian bare repo method](https://www.atlassian.com/git/tutorials/dotfiles).

This repository is a flat mirror of my home directory, keeping things simple and following Unix/KISS principles.

## Installation

To get started on a fresh machine, run the bootstrap script:

```bash
curl -fsSL "https://raw.githubusercontent.com/acbk2b/dotfiles/refs/heads/main/scripts/cfg.sh" | bash
```

This will:

1. Clone the repo as a bare git repository into `~/.cfg/`
2. Back up any conflicting files to `~/.config-backup/`
3. Check out the dotfiles into your home directory
4. Hide untracked files from `git status`

Once bootstrapped, use the `cfg` alias (defined in your shell `rc`) in place of `git` to manage dotfiles:

```bash
# Example -> update ghostty config
cfg status
cfg add .config/ghostty/config
cfg commit -m "update ghostty config"
cfg push
```

## Setup & Configuration

Automate your system setup by running the following scripts in order:

1. **Install Base Packages:**

   ```bash
   ./scripts/install-packages.sh
   ```

   _Detects OS (Arch, Debian/Ubuntu, Oracle Linux) and installs core CLI tools._

2. **System Configuration:**

   ```bash
   ./scripts/system-config.sh
   ```

   _Sets up TPM, and OS-specific tweaks like `yay` and `pacman` settings._

3. **Desktop Installation (Optional):**
   ```bash
   ./scripts/desktop-install.sh
   ```
   _Installs GUI tools (Hyprland, Alacritty, etc.) if a display environment is detected (currently Arch-only)._

## Layout

The repository is a direct mirror of the home directory:

- `.config/` -> `~/.config/`
- `.local/bin/` -> `~/.local/bin/`
- `.zshrc`, `.bashrc` -> symlinks to `.config/shell/rc` (one unified rc for both shells)

### Shell config

- `.config/shell/rc` — unified interactive rc, symlinked as both `~/.zshrc` and
  `~/.bashrc`. Shared logic up top; per-shell blocks fenced by `$ZSH_VERSION` /
  `$BASH_VERSION`.
- `.config/shell/profile` — login-shell setup (exports, runtime PATHs), linked
  via `~/.zprofile` / `~/.bash_profile`.
- `.config/shell/aliasrc` — aliases and shell functions.
- `.config/shell/env` — language runtime / PATH bootstrap (nvm, cargo, etc.).

### Non-dotfile configs

- `.config/keyboard/` — Keyboard firmware/launcher configuration exports (e.g., Keychron Launcher JSON profiles) stored for backup and portability.
