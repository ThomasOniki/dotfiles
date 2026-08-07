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
