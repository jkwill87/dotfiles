# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Chezmoi-managed dotfiles for macOS (primary) and Linux. The repo uses `.chezmoiroot` to point chezmoi at the `home/` subdirectory, keeping repo metadata (`mise.toml`, `license.txt`) out of the home directory.

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

Templates have access to `.name`, `.email` (prompted on `chezmoi init`), and all `.chezmoi.*` builtins. The `stat` function is used to conditionally include blocks only when a path exists on the current machine (e.g., JetBrains Toolbox PATH in `dot_profile.tmpl`).

## Architecture

- **Shell hierarchy**: `dot_profile.tmpl` (POSIX login env) is sourced by both `dot_bashrc.tmpl` and `dot_zshrc.tmpl`. Both bash and zsh source scripts from `dot_config/tty/*.{sh,bash,zsh}` for shared aliases, functions, and prompt setup.
- **Fish**: Standalone config, not part of the POSIX shell hierarchy. Uses fisher for plugin management; `run_onchange_after_fisher.sh.tmpl` watches `fish_plugins` by SHA256 hash.
- **Neovim**: Uses native `vim.pack` (not lazy.nvim). LSP configs live in `lsp/`, filetype settings in `ftplugin/`, plugin configs in `lua/plugins/`.
- **`.chezmoiignore`**: Conditionally skips `pacman.sh` on non-Linux and always ignores `fish_variables` (fish-generated, changes frequently).

## Platform Differences

macOS and Linux diverge in `run_once_before_setup.sh.tmpl` (Homebrew vs pacman) and `dot_profile.tmpl` (JetBrains Toolbox PATH). The `tty/pacman.sh` script is ignored on non-Linux via `.chezmoiignore`.
