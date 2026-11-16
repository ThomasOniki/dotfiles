[ -x /opt/homebrew/bin/brew ] || exit

export CPPFLAGS="-isysroot $(xcrun --show-sdk-path)"
export CFLAGS="$CFLAGS -isysroot "

source <(/opt/homebrew/bin/brew shellenv zsh)

export WINEPATH="$HOMEBREW_PREFIX/opt/mingw-w64/toolchain-x86_64/x86_64-w64-mingw32/bin;$HOMEBREW_PREFIX/opt/mingw-w64/toolchain-x86_64/x86_64-w64-mingw32/lib"
export WINEDEBUG="-all"

PATH="$HOMEBREW_PREFIX/bin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/rustup/bin:$PATH"
export PATH
