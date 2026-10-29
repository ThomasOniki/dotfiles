export FZF_DEFAULT_COMMAND='fd --type=file --hidden'
export FZF_DEFAULT_OPTS='--height=80% --layout=reverse --tmux="center,80%,60%"'

fzf_man() {
	local IFS=" "
	local entry=$(
		manpath |
			tr '\n' ':' |
			sed 's/::*/:/g' |
			tr ':' '\0' |
			xargs -0 fd --no-ignore --hidden --type file --full-path --follow '^.*/man([0-9]|3[a-z]*)/[^/]*\.([0-9]|3[a-z]*)(\.gz)?$' |
			sed 's/\(.*\)\/\([^/]*\)/\2    \1/' | fzf --query="$*" --preview='entry={}; mandoc "/${entry#*    /}/${entry%%    /*}" | bat --language=man --color=always'
	)

	[[ -n "$entry" ]] && mandoc "/${entry#*    /}/${entry%%    /*}" | v +Man!
}
fzf_zoxide_z() {
	local output
	FZF_DEFAULT_COMMAND="fd --type=directory --hidden" output=$(fzf --scheme=path "$@" </dev/tty) &&
		z "$output" &&
		zle accept-line
}
fzf_history() {
	local output
	output=$(history | fzf --scheme=history "$@") || return
	BUFFER=$(sed 's/[ ]*[0-9]*[ ]*//' <<<"$output")
	CURSOR=${#BUFFER}
	zle reset-prompt
}
fzf_tmux_session() {
	if [[ -z "$TMUX" ]]; then
		printf "\nfzf_tmux_session only works when you are already attached to a session"
		zle accept-line
		return 1
	fi
	local output
	output=$(tmux list-sessions -F '#{session_name}' | fzf) || return
	tmux switch-client -t "$output" <"$TTY"
}
fzf_tmux_window() {
	local output
	output=$(tmux list-windows -F '#{window_name}' | fzf) || return
}

zle -N fzf_man
zle -N fzf_zoxide_z
zle -N fzf_history
zle -N fzf_tmux_session
zle -N fzf_tmux_window

bindkey '^h' fzf_man
bindkey '^z' fzf_zoxide_z
bindkey '^r' fzf_history
bindkey '^f' fzf_tmux_session
bindkey '^w' fzf_tmux_window
