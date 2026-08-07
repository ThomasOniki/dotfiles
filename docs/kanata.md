## Requirements
- kanata
- the virtual HID device from karabiner elements (**only if you are on mac**, install with pkg installer [here](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases))

## Usage (linux / windows)
Have this constantly running in another terminal pane / window or use a launch service:
```sh 
kanata --cfg path/to/dotfiles/.config/kanata/config.kbd  --quiet
```

## Usage (mac)
If you didn't have the virtual HID installed previously, you will need to activate it. Run
```sh
/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate
```
When it prompts you, select open settings and enable `Driver Extension`.
The box doesn't appear checked immediately after clicking on it, but when you exit and re-enter the menu it is.

Then go to `System Settings` -> `Privacy & Security` -> `Input Monitoring` and add your kanata binary. I recomment using the cmd + shift + g shortcut and typing the path instead of navigating finder's tree.

If you cloned this to a protected folder (eg. ~/Desktop, ~/Documents), you may to grant disk access to kanata, because stow doesn't copy, it symlinks. Go to `System Settings` -> `Privacy & Security` -> `Full Disk Access`.

If you already had a daemon for the karabiner vhid, unload it:
```sh 
sudo launchctl bootout system path/to/karabiner_vhid_daemon.plist
```
Then run the setup script.
```sh 
scripts/setup_kanata_mac.sh
```
It may ask for the root password, because it creates two system wide launch daemoms. Feel free to look at the script if your are curious about what it does exactly.
[This guide](https://github.com/jtroo/kanata/discussions/1537) uses 3 daemons, but I found that you don't need the karabiner-vhidmanager one. If you are having issues though, consider adding it. If you know why I didn't need the 3rd daemon, please tell me.

## Troubleshooting (mac)
If you have issues, you can look at the exit codes of the virtual HID device and kanata by running 
```sh 
sudo launchctl list | grep keymap
```
Their logs can be seen in ~/Library/logs/kanata_stderr.log and ~/Library/Logs/kanata_stdout.log.

## Uninstall
If you are on windows or linux, disable whatever you were using to make kanata run continuously, then delete the files if you want to.
On Mac, first unload the daemons:
```
sudo launchctl bootout system /Library/LaunchDaemons/org.keymap.kanata.plist
sudo launchctl bootout system /Library/LaunchDaemons/org.keymap.karabiner-vhid.plist
```
Then you can delete the files. See the [repo](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/tree/main) if you want to uninstall the karabiner device.
