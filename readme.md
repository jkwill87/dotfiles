# dotfiles

Chezmoi-managed dotfiles for macOS and Linux.

## Install

```bash
chezmoi init --source ~/Sync/Development/dotfiles --apply
```

## Usage

```bash
chezmoi apply                    # deploy changes to ~
chezmoi diff                     # preview pending changes
chezmoi add ~/.config/foo        # start managing a new file
chezmoi re-add ~/.config/foo     # sync edits made at the target back to source
chezmoi edit ~/.config/foo       # edit source copy, apply on save
```

## What's Managed

- **Shells**: bash, zsh, fish, nushell
- **Editors**: neovim, helix, zed
- **Tools**: tmux, starship, git, mise, fzf, ssh
- **Scripts**: tty aliases, directory stack, gpg, prompt
