# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Chezmoi-managed dotfiles for macOS (primary), Arch Linux, and Debian/Ubuntu. The repo uses `.chezmoiroot` to point chezmoi at the `home/` subdirectory, keeping repo metadata (`mise.toml`, `license.txt`) out of the home directory.

## Chezmoi Commands

```bash
chezmoi apply              # deploy all managed files to ~
chezmoi diff               # preview pending changes
chezmoi add ~/.config/foo  # start managing a new file
chezmoi re-add ~/.config/zed/settings.json  # sync target edits back to source
chezmoi state delete-bucket --bucket=scriptState  # re-run run_once scripts
```

## Chezmoi Naming Conventions

| Prefix/Suffix | Effect |
|---|---|
| `dot_` | Becomes `.` in target path |
| `private_` | Sets 700/600 permissions |
| `.tmpl` | Rendered as Go template before copying |
| `run_once_before_` | Script that runs once on first apply |
| `run_onchange_after_` | Script that re-runs when watched content changes |

## Template Data

Templates have access to `.name`, `.email` (prompted on `chezmoi init`), and all `.chezmoi.*` builtins including `.chezmoi.os` (`darwin`/`linux`) and `.chezmoi.osRelease.id` (`arch`, `debian`, `ubuntu`) for platform branching.

## Architecture

- **Shell hierarchy**: `dot_profile` (POSIX login env) is sourced by both `dot_bashrc` and `dot_zshrc`. Both bash and zsh source scripts from `dot_config/tty/*.{sh,bash,zsh}` for shared aliases, functions, and prompt setup.
- **Fish**: Standalone config, not part of the POSIX shell hierarchy. Uses fisher for plugin management; `run_onchange_after_fisher.sh.tmpl` watches `fish_plugins` by SHA256 hash.
- **Neovim**: Uses native `vim.pack` (not lazy.nvim). LSP configs live in `lsp/`, filetype settings in `ftplugin/`, plugin configs in `lua/plugins/`.

## Platform Routing

Platform-specific code lives in dedicated tty scripts, deployed only to the relevant OS via `.chezmoiignore`:

| Script | Deployed to | Purpose |
|---|---|---|
| `tty/homebrew.sh` | macOS only | Homebrew PATH, bash/zsh completions |
| `tty/darwin.sh` | macOS only | LLVM toolchain, xcrun SDKROOT |
| `tty/linux.sh` | Linux only | xclip pbcopy/pbpaste aliases |
| `tty/pacman.sh` | Arch only | pacman helpers |
| `tty/debian.sh` | Debian/Ubuntu only | fdfind->fd alias |

## Tool Management

CLI tools (neovim, starship, fzf, fd, ripgrep, zoxide) are managed by **mise** via `dot_config/mise/config.toml`. System package managers (`brew`, `pacman`, `apt-get`) only install: fish, tmux, git, curl, build tools, and mise itself.

mise is activated in `dot_bashrc` and `dot_zshrc` after tty script sourcing:
```sh
command -v mise >/dev/null 2>&1 && eval "$(mise activate bash)"
```

## TTY Script Conventions

- Use `#!/bin/sh` for `.sh` files (POSIX, sourced by both bash and zsh)
- Use `command -v ... >/dev/null 2>&1` for command existence checks (not the legacy `exists` wrapper)
- Platform-specific code goes in the appropriate platform tty script, not behind runtime guards
