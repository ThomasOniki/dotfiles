source scripts/helpers.bash

echo "Installing the tailscaled LaunchDaemon, this may request your password..."

sudo cp tailscaled/sh.dotfiles.tailscaled.plist /Library/LaunchDaemons/sh.dotfiles.tailscaled.plist

if ! [[ -z "$TAILSCALED_BINARY" ]] || TAILSCALED_BINARY=$(command -v tailscaled); then
	sudo sed -i -e "s#/.*/tailscaled#$TAILSCALED_BINARY#g" tailscaled/sh.dotfiles.tailscaled.plist
	sudo sed -i -e "s#/.*/tailscaled#$TAILSCALED_BINARY#g" /Library/LaunchDaemons/sh.dotfiles.tailscaled.plist
else
	echo "Tailscaled binary not found. Make sure you have it installed and put it in \$PATH or set \$TAILSCALED_BINARY."
	exit 1
fi

sudo launchctl bootstrap system '/Library/LaunchDaemons/sh.dotfiles.tailscaled.plist'
