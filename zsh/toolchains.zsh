[ -x /usr/bin/xcrun ] && export SDKROOT="$(xcrun --show-sdk-path)"

use_brew_llvm_toolchain() {
	export CC="$HOMEBREW_PREFIX/opt/llvm/bin/clang" CXX="$HOMEBREW_PREFIX/opt/llvm/bin/clang++"
	export CPPFLAGS="-pipe -isysroot '$SDKROOT'"
	export CFLAGS="-std=c99"
	export CXXFLAGS="-std=c++23 -L/opt/homebrew/opt/llvm/lib/c++ -L/opt/homebrew/opt/llvm/lib/unwind -lunwind"
	export OBJCFLAGS="$CFLAGS" OBJCXXFLAGS="$CXXFLAGS"
	export LD="lld" LDFLAGS="-fuse-ld=lld"

	export AS="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-as"
	export AR="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ar" RANLIB="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ranlib"
	export STRIP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-strip"
	export OBJDUMP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-objdump" NM="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-nm"
	export CXXFILT="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-cxxfilt"
	export CLANGD="$HOMEBREW_PREFIX/opt/llvm/bin/clangd"
	export CLANG_TIDY="$HOMEBREW_PREFIX/opt/llvm/bin/clang-tidy"
	export RUN_CLANG_TIDY="$HOMEBREW_PREFIX/opt/llvm/bin/run-clang-tidy"
	export CLANG_FORMAT="$HOMEBREW_PREFIX/opt/llvm/bin/clang-format"
}

use_brew_gcc_toolchain() {
	local root="$(fd --type=directory --exact-depth=1 . "$HOMEBREW_PREFIX/Cellar/gcc" |
		sort --version-sort | tail -1)"
	root="${root%/}"
	local bin="${root}/bin"
	local ver="${root##*/}"
	ver="${ver%%.*}"

	export CC="$bin/gcc-$ver" CXX="$bin/g++-$ver"
	export CPPFLAGS="-pipe"
	export CFLAGS="-std=c99" CXXFLAGS="-std=c++23"
	export OBJCFLAGS="$CFLAGS" OBJCXXFLAGS="$CXXFLAGS"
	export LD="gold" LDFLAGS="-fuse-ld=gold"

	export AS="/usr/bin/as"
	export AR="$bin/gcc-ar-$ver" RANLIB="$bin/gcc-ranlib-$ver"
	export STRIP="$HOMEBREW_PREFIX/opt/binutils/bin/strip"
	export OBJDUMP="$HOMEBREW_PREFIX/opt/binutils/bin/objdump" NM="$bin/gcc-nm-$ver"
	export CXXFILT="$HOMEBREW_PREFIX/opt/binutils/bin/c++filt"
	export CLANGD="clangd"
	export CLANG_TIDY="clang-tidy"
	export RUN_CLANG_TIDY="run-clang-tidy"
	export CLANG_FORMAT="clang-format"
}

use_system_toolchain() {
	export CC="/usr/bin/clang" CXX="/usr/bin/clang++"
	export CPPFLAGS="-pipe"
	export CFLAGS="-std=c99" CXXFLAGS="-std=c++23"
	export OBJCFLAGS="$CFLAGS" OBJCXXFLAGS="$CXXFLAGS"
	export LD="" LDFLAGS=""

	export AS="/usr/bin/as"
	export AR="/usr/bin/ar" RANLIB="/usr/bin/ranlib"
	export STRIP="/usr/bin/strip"
	export OBJDUMP="/usr/bin/objdump" NM="/usr/bin/nm"
	export CXXFILT="/usr/bin/c++filt"
	export CLANGD="/usr/bin/clangd"
	export CLANG_TIDY="clang-tidy"
	export RUN_CLANG_TIDY="run-clang-tidy"
	export CLANG_FORMAT="clang-format"
}
