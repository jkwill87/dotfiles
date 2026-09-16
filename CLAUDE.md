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

Uses native `vim.pack` (not lazy.nvim). Neovim 0.12 or later required. `nvim-pack-lock.json` is chezmoi-managed and checked in, per `:h vim.pack-lockfile`.

**Load order** (`init.lua`): packs, colorscheme (kanagawa), options, plugin configs, inline plugin setups, keymaps, autocmds.

**Key files**:
- `lua/packs.lua` — declares all plugins via `vim.pack.add()` as "start" packages
- `lua/options.lua` — editor settings (2-space indent, no swap/backup, colorcolumn at 81/101/121, fold and popup config)
- `lua/keymaps.lua` — key mappings (barbar buffer nav, splits, terminal, format)
- `lua/autocmds.lua` — trim trailing whitespace on save, terminal mode tweaks
- `lua/plugins/*.lua` — per-plugin configuration (each file configures one plugin)
- `lsp/*.lua` — one file per language server, each exports `cmd`, `root_markers`, and optionally `filetypes`, `settings` or `on_attach`
- `ftplugin/*.lua` — per-filetype overrides (e.g., markdown enables soft wrap). Always use `vim.opt_local`, never `vim.o`, which would set the global value of a window-local option.

**Plugin config pattern**: each `lua/plugins/<name>.lua` file is `require`'d by `init.lua` and calls the plugin's `setup()`. `lua/plugins/lsp.lua` holds the explicit `vim.lsp.enable` list, whose names must each match a file in `lsp/`; enabling a name with no such file fails silently.

**Primary picker**: snacks.nvim (replaces telescope). Leader key mappings: `<Leader><Leader>` files, `<Leader>/` grep, `<Leader>bb` buffers, `<Leader>e` explorer.

**Native over plugins**: folding uses `vim.lsp.foldexpr` (no nvim-ufo), Copilot uses `vim.lsp.inline_completion` with `copilot-language-server` (no copilot.lua), colour hints use the default `vim.lsp.document_color` (no nvim-colorizer), and completion uses `vim.lsp.completion`. Prefer a core feature over adding a plugin.

**Keymap prefixes**: a bare mapping that is also the prefix of a longer mapping stalls for `timeoutlen` on every press. `lua/plugins/lsp.lua` deletes Nvim's global `gr*` LSP mappings for this reason, since `gr` is bound to references.

**Treesitter**: nvim-treesitter is on its `main` branch, so parsers come from the explicit list in `lua/plugins/treesitter.lua` via `require('nvim-treesitter').install()`. `:TSUpdate` only refreshes parsers already installed, so new languages must be added to that list. Requires the `tree-sitter` CLI, declared in `dot_config/mise/config.toml`. Indentation is deliberately left to Nvim's built-in indent scripts.

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

CLI tools (starship, fzf, fd, ripgrep, zoxide, tree-sitter) are managed by **mise** via `dot_config/mise/config.toml`. Neovim itself is not managed by mise. Neovim's language servers and formatters are installed by mason, from the list in `dot_config/nvim/init.lua`. System package managers (`brew`, `pacman`, `apt-get`) only install: fish, tmux, git, curl, build tools, and mise itself.

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
