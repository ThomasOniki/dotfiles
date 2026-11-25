fastfetch
tmux attach 2>/dev/null

PROMPT='%(?..%F{red}%B(%?%)%f%b )%~ ❯ '
HISTFILE="$XDG_STATE_HOME/zsh_history"
HISTSIZE=1000
HISTFILESIZE=1000
SAVEHIST=1000

source /usr/local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/local/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

source <(zoxide init zsh)
source <(cat "$XDG_CONFIG_HOME"/zsh/config/*.zsh)
