source scripts/helpers.bash

echo Removing kanata launch daemons, this may request your password...

sudo bash -c "source scripts/helpers.bash;
try_revert_ln kanata/kanata.kbd /etc/kanata.kbd;
"

sudo launchctl bootout system/sh.dotfiles.kanata
sudo rm /Library/LaunchDaemons/sh.dotfiles.kanata.plist

sudo launchctl bootout system/sh.dotfiles.karabiner-vhid
sudo rm /Library/LaunchDaemons/sh.dotfiles.karabiner-vhid.plist
