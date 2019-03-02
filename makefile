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

usage: make [bash, fd, shell, tmux, vim, zsh] | [all, clean]

endef

help:
	@: $(info $(usage))


# Bash -------------------------------------------------------------------------

.PHONY: bash

bash_profile_src := ./profile/profile.bash
bash_profile_dest := ${HOME}/.bash_profile
bash_rc_src := ./profile/rc.bash
bash_rc_dest := ${HOME}/.bashrc
bash_scripts_src := $(wildcard ./bash/*.bash)
bash_scripts_dest := ${HOME}/.config/bash

bash:
	cp $(bash_rc_src) $(bash_rc_dest)
	cp $(bash_profile_src) $(bash_profile_dest)
	mkdir -p $(bash_scripts_dest)
	cp $(bash_scripts_src) $(bash_scripts_dest)

bash-clean:
	rm -rvf $(bash_profile_dest) $(bash_rc_dest) $(bash_scripts_dest)


# Shell ------------------------------------------------------------------------

.PHONY: shell

shell_profile_src := ./profile/profile.sh
shell_profile_dest := ${HOME}/.profile
shell_scripts_src := $(wildcard ./shell/*.sh)
shell_scripts_dest := ${HOME}/.config/shell

shell:
	cp $(shell_profile_src) $(shell_profile_dest)
	mkdir -p $(shell_scripts_dest)
	cp -r $(shell_scripts_src) $(shell_scripts_dest)

shell-clean:
	rm -rvf $(shell_profile_dest) $(shell_scripts_dest)


# fd ---------------------------------------------------------------------------

.PHONY: fd

fd_src := ./fd/fdignore
fd_dest := ${HOME}/.fdignore

fd:
	cp $(fd_src) $(fd_dest)

fd-clean:
	rm -vf ${HOME}/.fdignore

# Tmux -------------------------------------------------------------------------

.PHONY: tmux

tmux_rc_src := ./tmux/tmux.conf
tmux_rc_dest := ${HOME}/.tmux.conf
tmux_script_src := $(wildcard ./tmux/*.bash)
tmux_script_dest := ${HOME}/.config/tmux

tmux:
	cp $(tmux_rc_src) $(tmux_rc_dest)
	mkdir -p $(tmux_script_dest)
	cp $(tmux_script_src) $(tmux_script_dest)

tmux-clean:
	rm -rvf $(tmux_rc_dest) ${tmux_script_dest}


# Vim --------------------------------------------------------------------------

.PHONY: vim vim-basic vim-plug nvim

vim: vim-basic vim-neo vim-plug
vimrc_src := ./vim/vim.conf
vimrc_dest := ${HOME}/.vimrc

vim-basic:
	cp $(vimrc_src) $(vimrc_dest)

plug_src := https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
plug_dest := ${HOME}/.vim/autoload/plug.vim

vim-plug:
	curl -Lo $(plug_dest) --create-dirs $(plug_src)
	vim -E -s -u $(vimrc_src) +PlugInstall +qa

nvim_dir := ${HOME}/.config/nvim
nvimrc_src := ./vim/nvim.conf
nvimrc_dest := $(nvim_dir)/init.vim

vim-neo:
	rm -rfv $(nvim_dir)
	mkdir $(nvim_dir)
	cp $(nvimrc_src) $(nvimrc_dest)

vim-clean:
	rm -rvf $(plug_dest) $(vimrc_dest) ${HOME}/.config/nvim ${HOME}/.vim


# Zsh --------------------------------------------------------------------------

.PHONY: zsh

zsh_profile_src := ./profile/profile.zsh
zsh_profile_dest := ${HOME}/.zprofile
zsh_rc_src := ./profile/rc.zsh
zsh_rc_dest := ${HOME}/.zshrc
zsh_scripts_src := ./zsh
zsh_scripts_dest := ${HOME}/.config/zsh

zsh:
	cp $(zsh_rc_src) $(zsh_rc_dest)
	cp $(zsh_profile_src) $(zsh_profile_dest)
	cp -r $(zsh_scripts_src) $(zsh_scripts_dest)

zsh-clean:
	rm -rvf $(zsh_profile_dest) $(zsh_rc_dest) $(zsh_scripts_dest)

# All --------------------------------------------------------------------------

clean: bash-clean shell-clean fd-clean tmux-clean vim-clean zsh-clean
all: bash shell fd tmux vim zsh
