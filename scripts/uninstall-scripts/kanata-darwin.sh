echo Removing kanata launch daemons, this may request your password...
sudo launchctl bootout system/org.keymap.kanata
sudo launchctl bootout system/org.keymap.karabiner-vhid

sudo rm /Library/LaunchDaemons/org.keymap.kanata.plist
sudo rm /Library/LaunchDaemons/org.keymap.karabiner-vhid.plist
