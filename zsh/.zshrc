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

alias c="clear"
alias d="trash"
alias rm="echo use d (an alias for trash) instead of rm."

po() {
	local output
	output="$("$@")" && bat <<<"$output"
}
alias ll="po lsd -lAh --color=always --icon=always"
alias l="lsd -A"

alias nvim="echo Use the alias v instead."
alias v="command nvim"
alias vimhost="v --cmd 'let g:live_share_username=\"host\"'"

alias q="builtin exit"
alias exit="echo Use the alias q instead"

[[ -n "$NVIM" ]] && function man() {
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

alias nts='tmux new -s "${PWD##*/}"'

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

alias lcc="$HOMEBREW_PREFIX/opt/llvm/bin/clang"
alias lcxx="$HOMEBREW_PREFIX/opt/llvm/bin/clang++"
alias llfmt="$HOMEBREW_PREFIX/opt/llvm/bin/clang-format"
alias lltidy="$HOMEBREW_PREFIX/opt/llvm/bin/clang-tidy"
alias llrtidy='$HOMEBREW_PREFIX/opt/llvm/bin/run-clang-tidy -clang-tidy-binary="$HOMEBREW_PREFIX/opt/llvm/bin/clang-tidy" -quiet'
alias llcxxfilt="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-cxxfilt"
alias dis='po "$OBJDUMP" --disassemble --disassembler-color=on'
alias ctestat='ctest --output-on-failure --timeout=20s --test-dir'

use_brew_llvm_toolchain() {
	export AS="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-as" CC="$HOMEBREW_PREFIX/opt/llvm/bin/clang" CXX="$HOMEBREW_PREFIX/opt/llvm/bin/clang++"
	export AR="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ar" RANLIB="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ranlib"
	export LD="lld" CC_LD="lld" CXX_LD="lld"
	export STRIP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-strip"
	export OBJDUMP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-objdump" NM="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-nm"
	export CLANGD="$HOMEBREW_PREFIX/opt/llvm/bin/clangd"
}
use_brew_gcc_toolchain() {
	local root="$(fd --type=directory --exact-depth=1 . "$HOMEBREW_PREFIX/Cellar/gcc" |
		sort --version-sort | tail -1)"
	root="${root%/}"
	local bin="${root}/bin"
	local ver="${root##*/}"
	ver="${ver%%.*}"
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
samplegraph() {
	exe="$1"
	shift
	sample "${exe##*/}" -wait -f "$HOME/.cache/sample.out" -fullPaths 2>/dev/null &
	"$exe" "$@"
	wait
	stackcollapse-sample.awk <"$HOME/.cache/sample.out" | flamegraph.pl >"$HOME/.cache/flamegraph.svg"
	librewolf "$HOME/.cache/flamegraph.svg"
}

cmk() {
	local subdir="$1"
	local build_type="$2"
	local flags="$3"
	local link_flags="$4"

	if [[ $# -gt 4 ]]; then
		shift 4
	else
		shift $#
	fi

	cmake \
		-B "builds/$subdir" \
		-G Ninja \
		-DCMAKE_BUILD_TYPE="$build_type" \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
		-DCMAKE_C_FLAGS="$flags" \
		-DCMAKE_CXX_FLAGS="$flags" \
		-DCMAKE_OBJC_FLAGS="$flags" \
		-DCMAKE_OBJCXX_FLAGS="$flags" \
		-DCMAKE_C_LINK_FLAGS="$link_flags" \
		-DCMAKE_CXX_LINK_FLAGS="$link_flags" \
		-DCMAKE_OBJC_LINK_FLAGS="$link_flags" \
		-DCMAKE_OBJCXX_LINK_FLAGS="$link_flags" \
		"$@"

	cmake --build "builds/$subdir"
}

alias cmkd='cmk ${CC##*/}/debug    Debug           ""                             ""'
alias cmka='cmk ${CC##*/}/asan     Debug           "-fsanitize=address,undefined" ""'
alias cmkr='cmk ${CC##*/}/release  RelWithDebInfo  ""                             ""'
alias cmks='cmk ${CC##*/}/stripped Release         ""                             "-s"'
alias cmkn='cmk ${CC##*/}/native   Release         "-march=native"                "-s"'

cmkmgw() {
	local subdir="$1"
	local build_type="$2"
	local flags="$3"
	local link_flags="$4"

	if [[ $# -gt 4 ]]; then
		shift 4
	else
		shift $#
	fi

	cmk \
		"$subdir" "$build_type" \
		"$flags" \
		"$link_flags -static-libgcc -static-libstdc++ -Wl,-Bstatic -lpthread -Wl,-Bdynamic" \
		-DCMAKE_SYSTEM_NAME=Windows \
		-DCMAKE_SYSTEM_PROCESSOR=x86_64 \
		-DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc \
		-DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-g++ \
		-DCMAKE_RC_COMPILER=x86_64-w64-mingw32-windres \
		-DCMAKE_CROSSCOMPILING_EMULATOR=wine \
		-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
		-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
		-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
		-DCMAKE_GET_RUNTIME_DEPENDENCIES_PLATFORM="windows+pe" \
		-DMINGW=ON \
		"$@"
}

alias cmkmgwd='cmkmgw mingw/debug    Debug           ""                              ""'
alias cmkmgwa='cmkmgw mingw/asan     Debug           "-fsanitize=address,undefined"  ""'
alias cmkmgwr='cmkmgw mingw/release  RelWithDebInfo  ""                              ""'
alias cmkmgws='cmkmgw mingw/stripped Release         ""                              "-s"'
alias cmkmgwn='cmkmgw mingw/native   Release         "-march=native"                 "-s"'
