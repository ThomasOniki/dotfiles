eval "$(/opt/homebrew/bin/brew shellenv zsh)"

PATH="$HOME/.local/bin:$PATH"
PATH="$HOMEBREW_PREFIX/bin:$PATH"

for formula in "bison" "ruby" "openjdk" "rustup" "llvm" "binutils" "curl"; do
  PATH="$HOMEBREW_PREFIX/opt/$formula/bin:$PATH"
done

export PATH

export EDITOR="$HOMEBREW_PREFIX/bin/nvim"
export PAGER="$HOMEBREW_PREFIX/opt/page/bin/page -WfC -q 90000 -z 90000"
export MANPAGER="$HOMEBREW_PREFIX/opt/page/bin/page -t man"

export CC="clang"
export CXX="clang++"
export CC_LD="lld"
export CXX_LD="lld"

export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/

export ASAN_OPTIONS="detect_leaks=1"
export LSAN_OPTIONS="suppressions=$HOME/.lsan_suppressions"

source $HOME/VulkanSDK/1.4.341.1/setup-env.sh >/dev/null
