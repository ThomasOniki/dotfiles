#/usr/bin/env bash

echo '
Running kanata setup script.
This script was based off of the guide by thomasthai on github:
https://github.com/jtroo/kanata/discussions/1537
If you are interested in what this script does, look at this page or read the source code for this script (scripts/setup-kanata-mac.sh).
You may press C-c at any point to exit.
'

if [[ "$BASH_SOURCE" != "$0" ]]; then
	echo "run this file, don't source it."
	return 0
fi

cd "$(dirname "$BASH_SOURCE")"

if [[ "$(command -v kanata)" == "" ]]; then

	if [[ "$(command -v brew)" == "" ]]; then
		if [[ "$(command -v cargo)" ]]; then
			echo "Neither kanata nor brew nor cargo found."
			exit
		fi
		echo "Kanata not found, installing with cargo..."
		cargo install kanata
	else
		echo "Kanata not found, installing with brew..."
		brew install kanata
	fi

fi

if ! [[ -f /Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager ]]; then
	echo "Karabiner vhid not found, cloning the repo temporarily..."
	git clone https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/ vhid-repo --depth 1 --filter=blob:none
	echo "Launching the karabiner virtual HID device installer, this may require your password."
	open -W vhid-repo/dist/Karabiner-DriverKit-VirtualHIDDevice-6.9.0.pkg
	echo "Deleting the vhid repo..."
	command rm -rf vhid-repo
	echo "When prompted (if prompted at all), please select the 'open settings' option and check 'Driver Extension'."
	/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate
fi

echo "Please add your kanata binary ($(command -v kanata)) to the list if you haven't already to grant it input monitoring permissions."
echo "After clicking on the '+', you can use the Cmd + Shift + G keyboard shortcut in the finder window and type the path to your binary."
echo "This may request your password."
open -W "x-apple.systempreferences:com.apple.preference.security?Privacy_ListenEvent"

echo "If you cloned this repo to a protected location (eg. ~/Desktop), please also grant full disk access to kanata."
echo "This is needed because otherwise kanata won't have permission to read your protected config file."
open -W "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"

kanata_plist='<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
 "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>org.keymap.kanata</string>'

kanata_plist="$kanata_plist
    <key>ProgramArguments</key>
    <array>
      <string>$(command -v kanata)</string>
      <string>--cfg</string>
      <string>$HOME/.config/kanata/config.kbd</string>
      <string>--quiet</string>
    </array>"

kanata_plist="$kanata_plist
<key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>

    <key>StandardOutPath</key>
    <string>$HOME/Library/Logs/kanata_stdout.log</string>

    <key>StandardErrorPath</key>
    <string>$HOME/Library/Logs/kanata_stderr.log</string>
  </dict>
</plist>"

karabiner_vhid_plist='<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>org.keymap.karabiner-vhid</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>'

echo "Creating launch daemons for kanata and the karabiner vhid, this may require your password."
echo "$kanata_plist" | sudo tee '/Library/LaunchDaemons/org.keymap.kanata.plist' >/dev/null
echo "$karabiner_vhid_plist" | sudo tee '/Library/LaunchDaemons/org.keymap.karabiner-vhid.plist' >/dev/null

echo 'Setup kanata successfully (hopefully).'
