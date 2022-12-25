#!/bin/bash
set -euo pipefail

case $(uname) in
Linux)
	gsettings get org.gnome.desktop.input-sources mru-sources | cut -d\' -f4
	;;
Darwin)
	defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -f 2 -d "=" | tr -d ' ;."'
	;;
esac
