eval "$(/opt/homebrew/bin/brew shellenv zsh)"

PATH="$HOME/.local/bin:$PATH"
PATH="$HOMEBREW_PREFIX/bin:$PATH"

for formula in "bison" "ruby" "openjdk" "rustup" "llvm" "binutils" "curl"; do
	PATH="$HOMEBREW_PREFIX/opt/$formula/bin:$PATH"
done

PATH="$HOMEBREW_PREFIX/opt/make/libexec/gnubin:$PATH"

export PATH

export MANPATH="$HOME/.cache/cppman:$MANPATH"

export EDITOR="nvim"
export PAGER="bat"
export MANPAGER="nvim -c Man!"

export CC="clang"
export CXX="clang++"
export CC_LD="lld"
export CXX_LD="lld"

export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/

source $HOME/VulkanSDK/1.4.341.1/setup-env.sh >/dev/null
