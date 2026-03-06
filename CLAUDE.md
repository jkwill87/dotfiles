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

| Prefix/Suffix         | Effect                                           |
| --------------------- | ------------------------------------------------ |
| `dot_`                | Becomes `.` in target path                       |
| `private_`            | Sets 700/600 permissions                         |
| `.tmpl`               | Rendered as Go template before copying           |
| `run_once_before_`    | Script that runs once on first apply             |
| `run_onchange_after_` | Script that re-runs when watched content changes |

## Template Data

Templates have access to `.name`, `.email` (prompted on `chezmoi init`), and all `.chezmoi.*` builtins including `.chezmoi.os` (`darwin`/`linux`) and `.chezmoi.osRelease.id` (`arch`, `debian`, `ubuntu`) for platform branching.

## Architecture

- **Shell hierarchy**: `dot_profile` (POSIX login env) is sourced by both `dot_bashrc` and `dot_zshrc`. Both bash and zsh source scripts from `dot_config/tty/*.{sh,bash,zsh}` for shared aliases, functions, and prompt setup.
- **Fish**: Standalone config, not part of the POSIX shell hierarchy. Uses fisher for plugin management. The `run_onchange_after_fisher.sh.tmpl` script watches `fish_plugins` by SHA256 hash — when plugins change, it cleans non-chezmoi-managed files from `functions/`, `completions/`, and `conf.d/`, then runs `fisher update`.
- **Neovim**: See dedicated section below.
- **Git**: `dot_gitconfig.tmpl` auto-detects SSH signing key (ed25519 > ecdsa > rsa) and configures GPG signing. Uses `gh auth git-credential` for GitHub credentials when `gh` is installed.
- **bin/**: Utility scripts in `home/bin/` (chezmoi `executable_` prefix). Includes `extract` (universal archive extractor), `battery`, `has` (feature detection), and various git helpers (`git-forget`, `git-redate`, `git-snap`).

## Neovim Architecture

Uses native `vim.pack` (not lazy.nvim). Neovim 0.12+ required.

**Load order** (`init.lua`): packs → options → plugin configs → keymaps → autocmds → colorscheme (kanagawa)

**Key files**:
- `lua/packs.lua` — declares all plugins via `vim.pack.add()` as "start" packages
- `lua/options.lua` — editor settings (2-space indent, no swap/backup, colorcolumn at 81/101/121)
- `lua/keymaps.lua` — key mappings (barbar buffer nav, splits, terminal, format)
- `lua/autocmds.lua` — trim trailing whitespace on save, terminal mode tweaks
- `lua/plugins/*.lua` — per-plugin configuration (each file configures one plugin)
- `lsp/*.lua` — one file per language server, each exports `cmd`, `filetypes`, `root_markers`, and optional `settings`
- `ftplugin/*.lua` — per-filetype overrides (e.g., markdown enables soft wrap)

**Plugin config pattern**: each `lua/plugins/<name>.lua` file is `require`'d by `init.lua` and calls the plugin's `setup()`. LSP servers are enabled in `lua/plugins/lsp.lua` which loops over configs from `lsp/`.

**Primary picker**: snacks.nvim (replaces telescope). Leader key mappings: `<Leader><Leader>` files, `<Leader>g` grep, `<Leader>b` buffers, `<Leader>e` explorer.

**Formatting**: conform.nvim — prettier for markdown/yaml, shfmt for shell scripts. `<Leader>f` to format.

## Platform Routing

Platform-specific code lives in dedicated tty scripts, deployed only to the relevant OS via `.chezmoiignore`:

| Script            | Deployed to        | Purpose                             |
| ----------------- | ------------------ | ----------------------------------- |
| `tty/homebrew.sh` | macOS only         | Homebrew PATH, bash/zsh completions |
| `tty/darwin.sh`   | macOS only         | LLVM toolchain, xcrun SDKROOT       |
| `tty/linux.sh`    | Linux only         | xclip pbcopy/pbpaste aliases        |
| `tty/pacman.sh`   | Arch only          | pacman helpers                      |
| `tty/debian.sh`   | Debian/Ubuntu only | fdfind->fd alias                    |

## Tool Management

CLI tools (neovim, starship, fzf, fd, ripgrep, zoxide) are managed by **mise** via `dot_config/mise/config.toml`. System package managers (`brew`, `pacman`, `apt-get`) only install: fish, tmux, git, curl, build tools, and mise itself.

mise is activated in `dot_bashrc` and `dot_zshrc` after tty script sourcing:

```sh
command -v mise >/dev/null 2>&1 && eval "$(mise activate bash)"
```

## Run-Once/Onchange Scripts

These chezmoi scripts use a SHA256 hash comment pattern to trigger re-execution when watched content changes:

```go
# dot_config/mise/config.toml hash: {{ include "dot_config/mise/config.toml" | sha256sum }}
```

- `run_once_before_setup.sh.tmpl` — bootstraps system packages and mise on first apply (platform-conditional)
- `run_onchange_after_mise-install.sh.tmpl` — runs `mise install --yes` when `config.toml` changes
- `run_onchange_after_fisher.sh.tmpl` — cleans stale fish plugin files and runs `fisher update` when `fish_plugins` changes

## Verification

```bash
chezmoi diff               # preview what would change
chezmoi apply -n           # dry-run apply
chezmoi doctor             # check chezmoi health
```

## TTY Script Conventions

- Use `#!/bin/sh` for `.sh` files (POSIX, sourced by both bash and zsh)
- Use `command -v ... >/dev/null 2>&1` for command existence checks (not the legacy `exists` wrapper)
- Platform-specific code goes in the appropriate platform tty script, not behind runtime guards
