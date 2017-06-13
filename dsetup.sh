#!/bin/bash
# Create a basic setup with rust, vim settings and proper bash settings
# Author: Nilangshu Bidyanta

echo "Environment setup"
echo "Prereqeuisites: git, vim, curl, autotools, an internet connection"
while true; do
	read -p "Do you wish to initiate the setup procedure? [y/n]: " yn
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) exit;;
		* ) ;;
	esac
done

vi_mode="set -o vi"
dircolor_entry="eval $(dircolors -b ~/.dircolors.256dark)"
alias_entry="alias cdw='cd $HOME/prj'"

echo "Creating project directory"
mkdir $HOME/prj

echo "Adding lines to .bashrc"
ret=$(grep -s "$vi_mode_entry" $HOME/.bashrc)
if [ $ret -eq 1 ]; then
	echo -e "\tEnabling Vi mode in bash"
	echo "$vi_mode_entry" >> $HOME/.bashrc
fi

ret=$(grep -s "$dircolor_entry" $HOME/.bashrc)
if [ $ret -eq 1 ]; then
	echo -e "\tAdding dircolor entry"
	echo "$dircolor_entry" >> $HOME/.bashrc
fi

ret=$(grep -s "$alias_entry" $HOME/.bashrc)
if [ $ret -eq 1 ]; then
	echo -e "\tCreating an alias for changing into work directory"
	echo "$alias_entry" >> $HOME/.bashrc
fi

echo "Copying configuration files"
echo -e "\tVim configuration file"
cp vimrc $HOME/.vimrc
echo -e "\tTmux configuration file"
cp tmux.conf $HOME/.tmux.conf
echo -e "\tDirectory theme file"
cp dircolors.256dark $HOME/.dircolors.256dark

echo "Populating vim plugins"
if [ ! -e "$HOME/.vim/autoload/pathogen.vim" ]; then
	echo -e "\tInstalling pathogen.vim"
	mkdir -p $HOME/.vim/autoload/ $HOME/.vim/bundle && \
		curl -LSso ~/.vim/autoload/pathogen.vim \
		https://tpo.pe/pathogen.vim
else
	echo -e "Pathogen already installed"
fi

if [ ! -d "$HOME/.vim/bundle/a.vim" ]; then
	echo -e "\tInstallingn A.vim"
	git clone https://github.com/vim-scripts/a.vim.git \
		$HOME/.vim/bundle/a.vim
else
	echo -e "\tA.vim already installed"
fi

if [ ! -d "$HOME/.vim/bundle/ctrlp.vim" ]; then
	echo -e "\tInstalling CtrlP"
	git clone https://github.com/ctrlpvim/ctrlp.vim.git \
		$HOME/.vim/bundle/ctrlp.vim
else
	echo -e "\tCtrlP already installed"
fi

if [ ! -d "$HOME/.vim/bundle/vim-autotag" ]; then
	echo -e "\tInstalling vim-autotag"
	git clone https://github.com/craigemery/vim-autotag.git \
		$HOME/.vim/bundle/vim-autotag
else
	echo -e "\tvim-autotag already installed"
fi

if [ ! -d "$HOME/.vim/bundle/vim-colors-solarized" ]; then
	echo -e "\tInstalling solarized theme"
	git clone https://github.com/altercation/vim-colors-solarized \
		$HOME/.vim/bundle/vim-colors-solarized
else
	echo -e "\tSolarized theme already installed"
fi

if [ ! -d "$HOME/.vim/bundle/syntastic" ]; then
	echo -e "\tInstalling Syntastic"
	git clone --depth=1 https://github.com/vim-syntastic/syntastic.git \
		$HOME/.vim/bundle/syntastic
else
	echo -e "\tSyntasic already installed"
fi

if [ ! -d "$HOME/.vim/bundle/rust.vim" ]; then
	echo -e "\tInstalling rust.vim"
	git clone --depth=1 https://github.com/rust-lang/rust.vim.git \
		$HOME/.vim/bundle/rust.vim
	echo "Don't forget to install rustfmt using:"
	echo "cargo install rustfmt"
else
	echo -e "\trust.vim already installed"
fi

if [ ! -d "$HOME/.cargo" ]; then
	while true; do
		read -p "Do you wish to install rust? [y/n]: " yn
		case $yn in
			[Yy]* ) curl https://sh.rustup.rs -sSf | sh;;
			[Nn]* ) break;;
			* ) ;;
		esac
	done
fi

ret=$(which ctags > /dev/null)
if [ $ret -eq 1 ]; then
	while true; do
		read -p "Do you wish to install rust? [y/n]: " yn
		case $yn in
			[Yy]*)
				git clone https://github.com/universal-ctags/ctags.git \
					/tmp/ctags
				cd /tmp/ctags && ./autogen.sh && ./configure && \
					make && sudo make install
				;;
			[Nn]* ) break;;
			* ) ;;
		esac
	done
fi

echo "Finished setting up environment"
