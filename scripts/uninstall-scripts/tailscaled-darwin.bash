source scripts/helpers.bash

echo "Uninstalling the tailscaled LaunchDaemon, this may request your password..."

sudo launchctl bootout system/sh.dotfiles.tailscaled
sudo rm /Library/LaunchDaemons/sh.dotfiles.tailscaled.plist
