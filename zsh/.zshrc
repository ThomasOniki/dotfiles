fastfetch

setopt autocd
setopt correct
setopt interactivecomments

PROMPT="%~ ❯ "

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

alias c="clear"
alias d="trash"
alias rm="echo use d (an alias for trash) instead of rm."

alias l="lsd --almost-all"
alias ll="lsd --almost-all --long --human-readable"

h() {
	$@ --help | nvim +Man!
}

fm() {
	files=$(manpath |
		tr '::' ':' | tr ':' '\0' |
		xargs -0 fd --no-ignore --hidden --type directory 'man([0-9]|3[a-z]*)' |
		tr '\n' '\0' |
		xargs -0 fd --no-ignore --hidden --type file .)

	local entries=""
	local pad=$((COLUMNS / 6))
	while IFS= read -r file; do
		fname="${file##*/}"
		entries+="$(printf "%-${pad}s - %s" "$fname" "$file")
"
	done <<<"$files"
	fzf <<<"$entries"
}
