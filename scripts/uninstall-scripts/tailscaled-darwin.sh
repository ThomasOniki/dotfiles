#!/bin/sh

root="$(dirname "$(readlink -f -- "$0")")/../.."
. "$root/scripts/helpers.sh"

echo "Uninstalling the tailscaled LaunchDaemon, this may request your password..."

sudo launchctl bootout system/sh.dotfiles.tailscaled
sudo rm /Library/LaunchDaemons/sh.dotfiles.tailscaled.plist
