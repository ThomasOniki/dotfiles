#!/bin/sh

root="$(dirname "$(readlink -f -- "$0")")/../.."
. "$root/scripts/helpers.sh"

echo "Installing the tailscaled LaunchDaemon, this may request your password..."

if [ -n "$TAILSCALED_BINARY" ] || TAILSCALED_BINARY=$(command -v tailscaled); then
	sed "s#BINARY_PATH#$TAILSCALED_BINARY#g" <"$root/tailscaled/sh.dotfiles.tailscaled.plist" |
		sudo tee /Library/LaunchDaemons/sh.dotfiles.tailscaled.plist >/dev/null
else
	echo "Tailscaled binary not found. Make sure you have installed it and put it in \$PATH or set \$TAILSCALED_BINARY."
	exit 1
fi

sudo launchctl bootstrap system '/Library/LaunchDaemons/sh.dotfiles.tailscaled.plist'
