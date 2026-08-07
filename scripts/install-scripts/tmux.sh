if ! [[ -d ~/.tmux/plugins/tpm ]]; then
	echo 'tpm (the Tmup Plugin Manager) not found, cloning to ~/.tmux/plugins/tpm...'
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

tmux source $HOME/.tmux.conf
