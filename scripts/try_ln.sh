#!/usr/bin/env bash

src="$(realpath $1)"
dst="$2"

if [[ -e "$dst" ]]; then
	echo $dst already exists, moving to $dst.bak.
	if [[ -e "$dst.bak" ]]; then
		echo $dst.bak also already exists.
		exit 1
	fi
	mv "$dst" "$dst.bak"
fi

echo "Creating symlink for $src at $dst..."

ln -s "$src" "$dst"
