#!/bin/sh

if command -v doas >/dev/null; then
	as_root=doas
else
	as_root=sudo
fi

echo "Uninstall plugins in /usr/local (y/n)?"
read -r answer
if [ "$answer" = "y" ]; then
	$as_root rm -rf /usr/local/share/zsh/plugins/zsh-autocomplete
	$as_root rm -rf /usr/local/share/zsh/plugins/zsh-autosuggestions
	$as_root rm -rf /usr/local/share/zsh/plugins/fast-syntax-highlighting
fi
