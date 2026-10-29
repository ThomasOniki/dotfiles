#!/bin/sh

[ "$WGETRC" = "${XDG_CONFIG_HOME:=$HOME/.config}/wget/wgetrc" ] || echo "Please set \$WGETRC to $XDG_CONFIG_HOME/wget/wgetrc in your shellrc or move the wgetrc symlink."
echo "hsts-file = ${XDG_STATE_HOME:-$HOME/.local/state}/wget-hsts" >wget/wgetrc
