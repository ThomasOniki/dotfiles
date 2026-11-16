use_default_toolchain() {
	export CPPFLAGS="-pipe -Werror"
	export CFLAGS="-std=c99"
	export CXXFLAGS="-std=c++23"
	export OBJCFLAGS="$CFLAGS"
	export OBJCXXFLAGS="$CXXFLAGS"
	export LDFLAGS=
	export CC= CXX= LD= AS= AR= RANLIB= STRIP= OBJDUMP= NM=
	export CXXFILT= CLANGD= CLANG_TIDY= RUN_CLANG_TIDY= CLANG_FORMAT=
}

use_gcc() {
	use_default_toolchain
	export CC=gcc CXX=g++
}
use_clang() {
	use_default_toolchain
	export CC=clang CXX=clang++
}

command -v gcc >/dev/null && use_gcc || use_clang
