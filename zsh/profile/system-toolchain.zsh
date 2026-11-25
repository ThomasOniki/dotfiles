use_default_toolchain() {
	export CPPFLAGS="-pipe -Werror"
	export CFLAGS="-std=c99"
	export CXXFLAGS="-std=c++23"
	export OBJCFLAGS="$CFLAGS"
	export OBJCXXFLAGS="$CXXFLAGS"
	export LDFLAGS=
	export CC=cc CXX=c++ LD=ld AS=as AR=ar RANLIB=ranlib STRIP=strip OBJDUMP=objdump NM=nm
	export CXXFILT=c++filt CLANGD=clangd CLANG_TIDY=clang-tidy RUN_CLANG_TIDY=run-clang-tidy CLANG_FORMAT=clang-format
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
