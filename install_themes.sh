#!/bin/bash

echo_section(){
echo ""
echo "-----------------------------------------"
echo "-- $1"
echo ""
}

echo_section "Installing GTK3 theme"

. "$HOME/.themes/install.sh"

echo_section "Installing GTK3 icon theme"

. "$HOME/.icons/install.sh"
. "$HOME/.icons/install_cursor.sh"

NORD_CLONE_DIR="$HOME/.nord_plugins"

[ ! -d $NORD_CLONE_DIR ] && mkdir $NORD_CLONE_DIR

echo_section "Installing terminator nord theme"

if [ -d "$NORD_CLONE_DIR/nord-terminator" ]
then
	(cd "$NORD_CLONE_DIR/nord-terminator" && git pull --quiet)	
else
	git clone https://github.com/arcticicestudio/nord-terminator.git "$NORD_CLONE_DIR/nord-terminator"
fi

(cd "$NORD_CLONE_DIR/nord-terminator" && . install.sh)
TERMINATOR_CONFIG_FILE="$HOME/.config/terminator/config"
#Also change font for terminator
grep "font|Inconsolata" "$TERMINATOR_CONFIG_FILE" > /dev/null
if [ $? -gt 0 ]
then
	sed -i -E "s/(\[global_config\])/\1\n  font = Inconsolata 14/" "$TERMINATOR_CONFIG_FILE"
else
	sed -i -E "s/font.*|.*Inconsolata/font = Inconsolata 14/i" "$TERMINATOR_CONFIG_FILE"
fi
#Change terminator default profile to nord
sed -i -E "s/\[\[nord\]\]/\[\[default\]\]/" "$TERMINATOR_CONFIG_FILE"
echo_section "Installing dircolor nord theme"

NORD_DIRCOLORS_DIR="$NORD_CLONE_DIR/nord-dircolors"
if [ -d  $NORD_DIRCOLORS_DIR ]
then
	(cd "$NORD_DIRCOLORS_DIR" && git pull --quiet)
else
	git clone https://github.com/arcticicestudio/nord-dircolors.git "$NORD_DIRCOLORS_DIR"
fi

(cd "$NORD_DIRCOLORS_DIR" && . install.sh 2> /dev/null > /dev/null)

#package is installed at $THOME/.dir_colors, but to fix it we create a symlink as .dircolors for bash
if [ $? -eq 1 ]
#dircolors will fail if the theme has already been instaled instead of greacefuly exiting; we assume success
then
	if [ ! -L "$HOME/.dircolors" ]
	then
		ln -s "$HOME/.dir_colors" "$HOME/.dircolors"
	fi
	echo "Installed successfully"
else
	echo "Something went unexpected with Nord Dircolors"
fi

echo_section "Installing vim nord theme"

VIMRC_FILE="$HOME/.vimrc"
NORD_VIM_DIR="$NORD_CLONE_DIR/nord-vim"

if [ -d "$NORD_VIM_DIR" ]
then
	(cd "$NORD_VIM_DIR" && git pull --quiet)
else
	git clone https://github.com/arcticicestudio/nord-vim.git "$NORD_VIM_DIR"
fi

cp -Ru "$NORD_VIM_DIR/colors" "$HOME/.vim/"

#Create .vimrc if not existing yet
if [ ! -f "$VIMRC_FILE" ]
then
	touch "$VIMRC_FILE" 
fi
grep "colorscheme" "$VIMRC_FILE" > /dev/null
if [ $? -gt 0 ];
then
	#color theme not defined yet
	echo "colorscheme nord" >> "$VIMRC_FILE"
	echo 6
else
	#color theme already defined; let's replace with 'nord'
	sed -i -E "s/^.*colorscheme.*$/colorscheme nord/" "$VIMRC_FILE"
	echo 8
fi

lxappearance &

