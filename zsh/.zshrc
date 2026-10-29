fastfetch

PROMPT='%(?..%F{red}%B(%?%)%f%b )%~ ❯ '
HISTFILE="$XDG_STATE_HOME/zsh_history"

if [ -n "$HOMEBREW_PREFIX" ]; then
	source $HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
	source $HOMEBREW_PREFIX/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	source $HOMEBREW_PREFIX/opt/zsh-autocomplete/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi

source <(zoxide init zsh)

source "$XDG_CONFIG_HOME/zsh/options.zsh"
source "$XDG_CONFIG_HOME/zsh/keybinds.zsh"
source "$XDG_CONFIG_HOME/zsh/aliases.zsh"
source "$XDG_CONFIG_HOME/zsh/toolchains.zsh"
source "$XDG_CONFIG_HOME/zsh/fzf.zsh"
