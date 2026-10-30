alias c="clear"
alias d="trash"

po() {
	local output
	output="$("$@")" && bat <<<"$output"
}
alias ll="po lsd -lAh --color=always --icon=always"
alias l="lsd -A"

alias v="command nvim"
alias vimhost="v --cmd 'let g:live_share_username=\"host\"'"

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
		"$link_flags" \
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

samplegraph() {
	exe="$1"
	shift
	sample "${exe##*/}" -wait -f "$HOME/.cache/sample.out" -fullPaths 2>/dev/null &
	"$exe" "$@"
	wait
	stackcollapse-sample.awk <"$HOME/.cache/sample.out" | flamegraph.pl >"$HOME/.cache/flamegraph.svg"
	librewolf "$HOME/.cache/flamegraph.svg"
}
