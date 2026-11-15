cmk() {
	local subdir="$1"
	local build_type="$2"
	local flags="$3"
	local link_flags="$LDFLAGS $4"

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
		-DCMAKE_C_FLAGS="$CPPFLAGS $CFLAGS $flags" \
		-DCMAKE_CXX_FLAGS="$CPPFLAGS $CXXFLAGS $flags" \
		-DCMAKE_OBJC_FLAGS="$CPPFLAGS $OBJCFLAGS $flags" \
		-DCMAKE_OBJCXX_FLAGS="$CPPFLAGS $OBJCXXFLAGS $flags" \
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
