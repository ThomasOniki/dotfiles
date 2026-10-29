#!/bin/sh

if ! [ -d "${XDG_DATA_HOME:=$HOME/.local/share}/tmux/plugins/tpm" ]; then
	echo "tpm (the Tmux Plugin Manager) not found, cloning to $XDG_DATA_HOME/tmux/plugins/tpm..."
	git clone https://github.com/tmux-plugins/tpm "$XDG_DATA_HOME/tmux/plugins/tpm"
fi

tmux source "${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf" 2>/dev/null
