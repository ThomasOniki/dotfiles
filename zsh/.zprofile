[ -z "$SSH_AUTH_SOCK" ] && source <(ssh-agent) >/dev/null

export PATH="$HOME/.local/bin:$PATH"

export MANPATH="$XDG_CACHE_HOME/cppman:$MANPATH"

export EDITOR="nvim"
export LESSUTFCHARDEF='E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p'
export PAGER="bat"
export MANPAGER="nvim -c Man!"
export BAT_STYLE="plain"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

source <(cat "$XDG_CONFIG_HOME"/zsh/profile/*.zsh)
