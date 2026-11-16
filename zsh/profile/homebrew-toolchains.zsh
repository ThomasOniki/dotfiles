source "$XDG_CONFIG_HOME/zsh/profile/system-toolchain.zsh"

use_brew_llvm_toolchain() {
	use_default_toolchain
	export CC="$HOMEBREW_PREFIX/opt/llvm/bin/clang" CXX="$HOMEBREW_PREFIX/opt/llvm/bin/clang++"
	export CPPFLAGS="$CPPFLAGS -isysroot '$SDKROOT'"
	export LD="lld" LDFLAGS="-fuse-ld=lld -L/opt/homebrew/opt/llvm/lib/c++ -L/opt/homebrew/opt/llvm/lib/unwind"

	export AS="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-mc"
	export AR="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ar" RANLIB="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ranlib"
	export STRIP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-strip"
	export OBJDUMP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-objdump" NM="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-nm"
	export CXXFILT="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-cxxfilt"
	export CLANGD="$HOMEBREW_PREFIX/opt/llvm/bin/clangd"
	export CLANG_TIDY="$HOMEBREW_PREFIX/opt/llvm/bin/clang-tidy"
	export RUN_CLANG_TIDY="$HOMEBREW_PREFIX/opt/llvm/bin/run-clang-tidy"
	export CLANG_FORMAT="$HOMEBREW_PREFIX/opt/llvm/bin/clang-format"
}

use_brew_llvm_toolchain

use_brew_gnu_toolchain() {
	use_default_toolchain

	local root="$(fd --type=directory --exact-depth=1 . "$HOMEBREW_PREFIX/Cellar/gcc" |
		sort --version-sort | tail -1)"
	root="${root%/}"
	local bin="${root}/bin"
	local ver="${root##*/}"
	ver="${ver%%.*}"

	export CC="$bin/gcc-$ver" CXX="$bin/g++-$ver"
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
