#!/usr/bin/env bash

if ! [[ -e "$2" ]]; then
	echo $2 not found
	exit 1
fi

if [[ "$(realpath \"$2\")" != "$(realpath \"$1\")" ]]; then
	echo $2 was not a symlink for $1, not deleting it.
	exit 1
fi

echo Removing symlink for $1 at $2...
command rm -rf $2

if [[ -e "$2.bak" ]]; then
	echo Restoring $2.bak to $2...
	mv "$2.bak" "$2"
fi
