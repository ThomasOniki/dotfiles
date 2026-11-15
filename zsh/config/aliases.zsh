alias c="clear"
alias d="trash"

po() {
	local output
	output="$("$@")" && bat <<<"$output"
}
alias ll="po lsd -lAh --color=always --icon=always"
alias l="lsd -A"

alias v="command nvim"
alias vimhost="v -c 'LiveShareHostStart'"

alias q="builtin exit"

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

alias fd='fd -E ".git" -E "z:" -E "/System/Volumes/Data"'

alias a='./a.out'

cc() {
	for arg in "$@"; do
		if [ "$arg" = "-c" ]; then
			local LDFLAGS=
		elif [ "$arg" = "--" ]; then
			break
		fi
	done
	sh -c "$CC $CPPFLAGS $CFLAGS $LDFLAGS \"\$@\"" arg0 "$@"
}
compdef '_dispatch "$CC" "${CC##*/}"' cc
cxx() { CC="$CXX" CFLAGS="$CXXFLAGS" cc "$@"; }
compdef '_dispatch "$CXX" "${CXX##*/}"' cxx

alias dis='po "$OBJDUMP" --disassemble --disassembler-color=on'
alias ctestat='ctest --output-on-failure --timeout=20s --test-dir'

alias cxxfilt="${CXXFILT:-c++filt}"
alias llfmt="${CLANG_FORMAT:-clang-format}"
alias lltidy="${CLANG_TIDY:-clang-tidy}"
alias llrtidy='${RUN_CLANG_TIDY:-run-clang-tidy} -clang-tidy-binary="${CLANG_TIDY:-clang-tidy}" -quiet'

samplegraph() {
	exe="$1"
	shift
	sample "${exe##*/}" -wait -f "$HOME/.cache/sample.out" -fullPaths 2>/dev/null &
	"$exe" "$@"
	wait
	stackcollapse-sample.awk <"$HOME/.cache/sample.out" | flamegraph.pl >"$HOME/.cache/flamegraph.svg"
	librewolf "$HOME/.cache/flamegraph.svg"
}

source "$XDG_CONFIG_HOME/zsh/profile/homebrew-toolchains.zsh"
