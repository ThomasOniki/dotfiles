[[ "$WGETRC" = "$XDG_CONFIG_HOME/wget/wgetrc" ]] || echo 'Please set WGETRC to $XDG_CONFIG_HOME/wget/wgetrc in your shellrc or move the wgetrc symlink.'
echo "hsts-file = $XDG_STATE_HOME/wget-hsts" >wget/wgetrc
