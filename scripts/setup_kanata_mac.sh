#!/bin/bash

# This shebang isn't portable. This is by design, you shouldn't run this script on anything other than a mac.

/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate

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
      <string>--quiet/string>
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
    <string>org.keymap.karabiner-vhiddaemon</string>
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

echo "$kanata_plist" | sudo tee '/Library/LaunchDaemons/org.keymap.kanata.plist' >/dev/null
echo "$karabiner_vhid_plist" | sudo tee '/Library/LaunchDaemons/org.keymap.karabiner-vhid.plist' >/dev/null
