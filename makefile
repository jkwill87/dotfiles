# makefile
# jessy@jessywilliams.com


# Help -------------------------------------------------------------------------

define usage

     .::            .::      .::    .::
     .::            .::    .:    .: .::
     .::   .::    .:.: .:.:.: .:    .::   .::     .::::
 .:: .:: .::  .::   .::    .::  .:: .:: .:   .:: .::
.:   .::.::    .::  .::    .::  .:: .::.::::: .::  .:::
.:   .:: .::  .::   .::    .::  .:: .::.:            .::
 .:: .::   .::       .::   .::  .::.:::  .::::   .:: .::

usage: make [tty, lint, tmux, vim, util] | [all, clean]

endef

help:
	@: $(info $(usage))


# TTY --------------------------------------------------------------------------

tty_dest := ${HOME}/.config/tty

tty: profile shell bash zsh
	touch ${HOME}/.dirstack

tty-clean: shell-clean bash-clean zsh-clean
	@rm -rvf $(tty_dest)

.PHONY: tty


# Shell ------------------------------------------------------------------------

shell_tty_src := $(wildcard ./tty/*.sh)
shell_profile_src := ./profile/profile.sh
shell_profile_dest := ${HOME}/.profile

shell:
	$(info CONFIGURING SHELL)
	@cp -v $(shell_profile_src) $(shell_profile_dest)
	@mkdir -pv $(tty_dest)
	@cp -rv $(shell_tty_src) $(tty_dest)

shell-clean:
	$(info CLEANING SHELL)
	@rm -rvf $(wildcard $(tty_dest)/*.sh)
	@rm -rvf $(shell_profile_dest)


# Bash -------------------------------------------------------------------------

bash_tty_src := $(wildcard ./tty/*.bash)
bash_profile_src := ./profile/profile.bash
bash_profile_dest := ${HOME}/.bash_profile
bash_rc_src := ./profile/rc.bash
bash_rc_dest := ${HOME}/.bashrc
z_src := ./profile/z.bash
z_dest := ${HOME}/.z.bash

bash:
	$(info CONFIGURING BASH)
	@cp -v $(bash_profile_src) $(bash_profile_dest)
	@cp -v $(bash_rc_src) $(bash_rc_dest)
	@mkdir -pv $(tty_dest)
	@cp -rv $(bash_tty_src) $(tty_dest)
	@cp -v $(z_src) $(z_dest)

bash-clean:
	$(info CLEANING BASH)
	@rm -rvf $(wildcard $(tty_dest)/*.bash)
	@rm -rvf $(bash_profile_dest)


# Zsh --------------------------------------------------------------------------

zsh_tty_src := $(wildcard ./tty/*.zsh)
zsh_profile_src := ./profile/profile.zsh
zsh_profile_dest := ${HOME}/.zprofile
zsh_rc_src := ./profile/rc.zsh
zsh_rc_dest := ${HOME}/.zshrc

zsh:
	$(info CONFIGURING ZSH)
	@cp -v $(zsh_profile_src) $(zsh_profile_dest)
	@cp -v $(zsh_rc_src) $(zsh_rc_dest)
	@mkdir -vp $(tty_dest)
	@cp -rv $(zsh_tty_src) $(tty_dest)
	@cp -v $(z_src) $(z_dest)

zsh-clean:
	$(info CLEANING ZSH)
	@rm -rvf $(wildcard $(tty_dest)/*.zsh)
	rm -rvf $(zsh_profile_dest)


# Lint -------------------------------------------------------------------------

pylint_src := ./lint/pylint.config
pylint_dest := ${HOME}/.pylintrc

lint:
	cp $(pylint_src) $(pylint_dest)

lint-clean:
	rm -rvf $(pylint_dest)

.PHONY: lint


# Tmux -------------------------------------------------------------------------

tmux_rc_src := ./tmux/tmux.conf
tmux_rc_dest := ${HOME}/.tmux.conf
tmux_script_src := $(wildcard ./tmux/*.bash)
tmux_script_dest := ${HOME}/.config/tmux

tmux:
	cp $(tmux_rc_src) $(tmux_rc_dest)
	mkdir -p $(tmux_script_dest)
	cp $(tmux_script_src) $(tmux_script_dest)
	chmod +x $(tmux_script_dest)/*

tmux-clean:
	rm -rvf $(tmux_rc_dest) ${tmux_script_dest}

.PHONY: tmux


# Vim --------------------------------------------------------------------------

vim: vim-basic vim-neo vim-plug
vimrc_src := ./vim/vim.conf
vimrc_dest := ${HOME}/.vimrc

vim-basic:
	cp $(vimrc_src) $(vimrc_dest)

plug_src := https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
plug_dest := ${HOME}/.vim/autoload/plug.vim

vim-plug:
	-curl --max-time 5 --retry 2 -Lo $(plug_dest) --create-dirs $(plug_src)
	-vim -E -s -u $(vimrc_src) +PlugInstall +qa

nvim_dir := ${HOME}/.config/nvim
nvimrc_src := ./vim/nvim.conf
nvimrc_dest := $(nvim_dir)/init.vim

vim-neo:
	rm -rfv $(nvim_dir)
	mkdir $(nvim_dir)
	cp $(nvimrc_src) $(nvimrc_dest)

vim-clean:
	rm -rvf $(plug_dest) $(vimrc_dest) ${HOME}/.config/nvim ${HOME}/.vim

.PHONY: vim vim-basic vim-plug nvim


# Util -------------------------------------------------------------------------

fd_src := ./util/fdignore.txt
fd_dest := ${HOME}/.fdignore
tldr_src := ./util/tldr.json
tldr_dest := ${HOME}/.tldrrc

util:
	cp $(fd_src) $(fd_dest)
	cp $(tldr_src) $(tldr_dest)

util-clean:
	rm -vf $(fd_dest) $(tldr_dest)

.PHONY: util


# All --------------------------------------------------------------------------

clean: tty-clean lint-clean tmux-clean vim-clean util-clean
all: tty lint tmux vim util
