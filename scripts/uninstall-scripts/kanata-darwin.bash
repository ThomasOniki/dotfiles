echo Removing kanata launch daemons, this may request your password...
sudo launchctl bootout system/sh.dotfiles.kanata
sudo launchctl bootout system/sh.dotfiles.karabiner-vhid

sudo rm /Library/LaunchDaemons/sh.dotfiles.kanata.plist
sudo rm /Library/LaunchDaemons/sh.dotfiles.karabiner-vhid.plist
