#!/bin/sh

osascript -e "display notification \"$(ps -p 1337 -o comm=)\" with title \"SSH\""

if ssh-add -l >/dev/null 2>&1; then
	nc "$1" "$2"
	exit
fi

if ! pgrep KeePassXC >/dev/null; then
	open -a KeePassXC
	sleep 1
fi

open -a KeePassXC

until ssh-add -l >/dev/null 2>&1; do
	sleep 1
done

nc "$1" "$2"
