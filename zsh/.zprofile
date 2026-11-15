[ -z "$SSH_AUTH_SOCK" ] && source <(ssh-agent) >/dev/null

export PATH="$HOME/.local/bin:$PATH"

export MANPATH="$XDG_CACHE_HOME/cppman:$MANPATH"

export EDITOR="nvim"
export LESSUTFCHARDEF='E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p'
export PAGER="bat"
export MANPAGER="nvim -c Man!"
export BAT_STYLE="plain"

source "$XDG_CONFIG_HOME"/zsh/profile/*.zsh
