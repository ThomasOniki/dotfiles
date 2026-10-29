bindkey -v
bindkey -M vicmd 'n' vi-backward-char
bindkey -M vicmd 'i' vi-forward-char
bindkey -M vicmd 'e' down-line-or-select
bindkey -M vicmd 'u' up-line-or-search

bindkey -M vicmd 'r' vi-backward-word
bindkey -M vicmd 't' vi-forward-word
bindkey -M vicmd 'h' vi-first-non-blank
bindkey -M vicmd 'o' vi-end-of-line

bindkey -M vicmd 'a' vi-insert
bindkey -M vicmd 'w' vi-add-next

bindkey -M vicmd 'q' undo

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
