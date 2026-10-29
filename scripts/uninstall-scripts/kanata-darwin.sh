#!/bin/sh

root="$(dirname "$(readlink -f -- "$0")")/../.."
. "$root/scripts/helpers.sh"

echo Removing kanata launch daemons, this may request your password...

sudo sh -c ". '$root/scripts/helpers.sh';
try_revert_ln '$root/kanata/kanata.kbd' /etc/kanata.kbd;
"

sudo launchctl bootout system/sh.dotfiles.kanata
sudo rm /Library/LaunchDaemons/sh.dotfiles.kanata.plist

sudo launchctl bootout system/sh.dotfiles.karabiner-vhid
sudo rm /Library/LaunchDaemons/sh.dotfiles.karabiner-vhid.plist
