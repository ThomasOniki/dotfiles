#!/bin/sh

if command -v doas >/dev/null; then
	as_root=doas
else
	as_root=sudo
fi

echo "Install plugins to /usr/local (y/n)?"
read -r answer
if [ "$answer" = "y" ]; then
	$as_root mkdir -p /usr/local/share/zsh/plugins
	$as_root git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete.git /usr/local/share/zsh/plugins/zsh-autocomplete
	$as_root git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git /usr/local/share/zsh/plugins/zsh-autosuggestions
	$as_root git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git /usr/local/share/zsh/plugins/fast-syntax-highlighting
fi
