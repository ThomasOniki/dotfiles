fastfetch

setopt autocd
setopt correct
setopt interactivecomments
setopt sharehistory
setopt promptsubst

PROMPT='%(?..%F{red}%B(%?%)%f%b )%~ ❯ '
HISTFILE="$XDG_STATE_HOME/zsh_history"

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

po() { output=$("$@") && bat <<<"$output"; }
alias ll="po lsd -lAh --color=always --icon=always"
alias l="lsd -A"

alias nvim="echo Use the alias v instead."
alias v="command nvim"
alias vimhost="v --cmd 'let g:live_share_username=\"host\"'"

alias bwul='export BW_SESSION="$(bw unlock --raw)"'

alias q="builtin exit"
alias exit="echo Use the alias q instead"

alias lcc="$HOMEBREW_PREFIX/opt/llvm/bin/clang"
alias lc++="$HOMEBREW_PREFIX/opt/llvm/bin/clang++"
alias dis='po $OBJDUMP --disassemble --disassembler-color=on'
alias ctestat='ctest --output-on-failure --timeout=20s --test-dir'

samplegraph() {
	exe="$1"
	shift
	sample "${exe##*/}" -wait -f "$HOME/.cache/sample.out" -fullPaths 2>/dev/null &
	"$exe" "$@"
	wait
	stackcollapse-sample.awk <"$HOME/.cache/sample.out" | flamegraph.pl >"$HOME/.cache/flamegraph.svg"
	librewolf "$HOME/.cache/flamegraph.svg"
}

[[ -z "$NVIM" ]] || function man() {
	# used for completions
	if [[ "$*" = --- ]]; then
		command man ---
		return
	fi

	v --server "$NVIM" --remote-send "<cmd>hide Man $*<cr>"
}

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

use_brew_llvm_toolchain() {
	export AS="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-as" CC="$HOMEBREW_PREFIX/opt/llvm/bin/clang" CXX="$HOMEBREW_PREFIX/opt/llvm/bin/clang++"
	export AR="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ar" RANLIB="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ranlib"
	export LD="lld" CC_LD="lld" CXX_LD="lld"
	export STRIP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-strip"
	export OBJDUMP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-objdump" NM="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-nm"
	export CLANGD="$HOMEBREW_PREFIX/opt/llvm/bin/clangd"
}

use_brew_gcc_toolchain() {
	local bin="$(fd --type=directory --exact-depth=2 --follow --absolute-path --full-path "^$HOMEBREW_PREFIX/opt/gcc@[0-9]*/bin$" "$HOMEBREW_PREFIX/opt" |
		sort --version-sort | tail -1)"
	bin="${bin%/}"
	local ver="${bin##*gcc@}"
	ver="${ver%/bin}"
	export AS="/usr/bin/as" CC="$bin/gcc-$ver" CXX="$bin/g++-$ver"
	export AR="$bin/gcc-ar-$ver" RANLIB="$bin/gcc-ranlib-$ver"
	export LD="gold" CC_LD="gold" CXX_LD="gold"
	export STRIP="$HOMEBREW_PREFIX/opt/binutils/bin/strip"
	export OBJDUMP="$HOMEBREW_PREFIX/opt/binutils/bin/objdump" NM="$bin/gcc-nm-$ver"
	export CLANGD="/usr/bin/clangd"
}

use_system_toolchain() {
	export AS="/usr/bin/as" CC="/usr/bin/clang" CXX="/usr/bin/clang++"
	export AR="/usr/bin/ar" RANLIB="/usr/bin/ranlib"
	export LD= CC_LD= CXX_LD=
	export STRIP="/usr/bin/strip"
	export OBJDUMP="/usr/bin/objdump" NM="/usr/bin/nm"
	export CLANGD="/usr/bin/clangd"
}
