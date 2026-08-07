fastfetch

alias c="clear"
alias rm="trash"

alias ls="lsd --almost-all"
alias lsl="lsd --almost-all --long"

fm() {
	fd --no-ignore --hidden --absolute-path --type=directory --follow . $(manpath 2>/dev/null |
		sed 's/:/\n/g') 2>/dev/null |
		rg --color=never '/man[1-9nl]' |
		xargs fd --no-ignore --hidden --absolute-path --type=file --follow . |
		sed 's/\(.*\)\.gz/\1/g' |
		sed 's/.*\/\([^\/]*\)\.\(.*\)/\1(\2)/g' |
		fzf --query="$@" --preview='man -P "bat --language=man --color=always" "$(sed "s/.*(\(.*\))/\1/g" <<<{})" "$(sed "s/(.*//g" <<<{})"' |
		sed 's/\(.*\)(\(.*\))/\2 "\1"/g' 2>/dev/null |
		xargs man
}

PROMPT="%~ > "

# This makes sure you don't nest neovim sessions.
[[ -z "$NVIM" ]] || alias nvim="open -a neovide"

source $HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

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

source $HOMEBREW_PREFIX/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/opt/zsh-autocomplete/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

autoload -Uz edit-command-line
zle -N edit-command-line

bindkey '^e' edit-command-line

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND='rg --hidden --files'
