fastfetch

setopt autocd
setopt correct
setopt interactivecomments

PROMPT="%~ ❯ "

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

source <(zoxide init zsh)
source <(fzf --zsh)

export FZF_DEFAULT_COMMAND='rg --hidden --files'

alias c="clear"
alias d="trash"
alias rm="echo use d (an alias for trash) instead of rm."

alias l="lsd --almost-all"
alias ll="lsd --almost-all --long --human-readable"

alias nvim="echo Use the alias v instead."
alias v="command nvim"
alias vimhost="v --cmd 'let g:live_share_username=\"host\"'"

alias q="exit"
alias exit="echo Use the alias q instead"

h() {
	$@ --help | v +Man!
}

fm() {
	local IFS=" "
	entry=$(
		manpath |
			tr '\n' ':' |
			sed 's/::*/:/g' |
			tr ':' '\0' |
			xargs -0 fd --no-ignore --hidden --type file --full-path --follow '^.*/man([0-9]|3[a-z]*)/[^/]*\.([0-9]|3[a-z]*)(\.gz)?$' |
			sed 's/\(.*\)\/\([^/]*\)/\2    \1/' | fzf --query="$*" --preview='entry={}; mandoc "/${entry#*    /}/${entry%%    /*}" | bat --language=man --color=always'
	)

	[[ -z "$entry" ]] || mandoc "/${entry#*    /}/${entry%%    /*}" | v +Man!
}
