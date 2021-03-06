#!/bin/bash
# Create a basic setup with vim settings and proper bash settings
# Author: Nilangshu Bidyanta

# Check for prerequisite programs
check_pre()
{
	which $1 > /dev/null
	if [ "$?" -eq "1" ]; then
		echo "Prerequisite missing: $1"
		exit 1
	else
		echo "Found $1"
	fi
}

echo "Environment setup"
echo "Prereqeuisites: git, vim, curl, autotools, pkg-config, cmake, astyle, an internet connection"
while true; do
	read -p "Do you wish to initiate the setup procedure? [y/n]: " yn
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) exit 1;;
		* ) ;;
	esac
done

check_pre git
check_pre vim
check_pre curl
check_pre autoconf
check_pre automake
check_pre pkg-config
check_pre cmake
check_pre astyle

vi_mode_entry="set -o vi"
dircolor_entry="eval \$(dircolors -b ~/.dircolors.256dark)"
alias_entry="alias cdw='cd $HOME/prj'"

echo "Creating project directory"
mkdir -p $HOME/prj

echo "Attempting to add lines to .bashrc"
grep -sq "$vi_mode_entry" $HOME/.bashrc
if [ "$?" -eq "1" ]; then
	echo -e "\tEnabling Vi mode in bash"
	echo "$vi_mode_entry" >> $HOME/.bashrc
fi

grep -sq "$dircolor_entry" $HOME/.bashrc
if [ "$?" -eq "1" ]; then
	echo -e "\tAdding dircolor entry"
	echo "$dircolor_entry" >> $HOME/.bashrc
fi

grep -sq "$alias_entry" $HOME/.bashrc
if [ "$?" -eq "1" ]; then
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
	echo -e "\n\tInstalling pathogen.vim"
	mkdir -p $HOME/.vim/autoload/ $HOME/.vim/bundle && \
		curl -LSso ~/.vim/autoload/pathogen.vim \
		https://tpo.pe/pathogen.vim
else
	echo -e "\n\tPathogen already installed"
fi

if [ ! -d "$HOME/.vim/bundle/a.vim" ]; then
	echo -e "\n\tInstallingn A.vim"
	git clone https://github.com/vim-scripts/a.vim.git \
		$HOME/.vim/bundle/a.vim
else
	echo -e "\n\tA.vim already installed"
fi

if [ ! -d "$HOME/.vim/bundle/ctrlp.vim" ]; then
	echo -e "\n\tInstalling CtrlP"
	git clone https://github.com/ctrlpvim/ctrlp.vim.git \
		$HOME/.vim/bundle/ctrlp.vim
else
	echo -e "\n\tCtrlP already installed"
fi

if [ ! -d "$HOME/.vim/bundle/vim-autotag" ]; then
	echo -e "\n\tInstalling vim-autotag"
	git clone https://github.com/craigemery/vim-autotag.git \
		$HOME/.vim/bundle/vim-autotag
else
	echo -e "\n\tvim-autotag already installed"
fi

if [ ! -d "$HOME/.vim/bundle/vim-colors-solarized" ]; then
	echo -e "\n\tInstalling solarized theme"
	git clone https://github.com/altercation/vim-colors-solarized \
		$HOME/.vim/bundle/vim-colors-solarized
else
	echo -e "\n\tSolarized theme already installed"
fi

if [ ! -d "$HOME/.vim/bundle/vim-cmake-syntax" ]; then
	echo -e "\n\tInstalling vim cmake syntax files"
	git clone https://github.com/pboettch/vim-cmake-syntax.git \
		$HOME/.vim/bundle/vim-cmake-syntax
else
	echo -e "\n\tVim Cmake syntax files already installed"
fi

which ctags > /dev/null
if [ "$?" -eq "1" ]; then
	while true; do
		read -p "Do you wish to install ctags? [y/n]: " yn
		case $yn in
			[Yy]*)
				rm -rf /tmp/ctags
				git clone https://github.com/universal-ctags/ctags.git \
					/tmp/ctags
				cd /tmp/ctags && ./autogen.sh && ./configure && \
					make && sudo make install
				break
				;;
			[Nn]* ) break;;
			* ) ;;
		esac
	done
fi

echo "Finished setting up environment"
echo "Please restart the shell"
