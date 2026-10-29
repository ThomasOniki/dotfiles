#!/bin/sh

[ "$NPM_CONFIG_USERCONFIG" = "${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc" ] || echo "Please set \$NPM_CONFIG_USERCONFIG to $XDG_CONFIG_HOME/npm/npmrc in your shellrc or move the npmrc symlink."
