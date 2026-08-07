source <(/opt/homebrew/bin/brew shellenv zsh)

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"

PATH="$HOME/.local/bin:$PATH"
PATH="$HOMEBREW_PREFIX/bin:$PATH"

for formula in "bison" "ruby" "openjdk" "rustup" "llvm" "binutils" "curl"; do
	PATH="$HOMEBREW_PREFIX/opt/$formula/bin:$PATH"
done

PATH="$HOMEBREW_PREFIX/opt/make/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/ccache/libexec:$PATH"

export PATH

export MANPATH="$XDG_CACHE_HOME/cppman:$MANPATH"

export EDITOR="nvim"
export LESSUTFCHARDEF='E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p'
export PAGER="bat"
export MANPAGER="nvim -c Man!"

export CC="clang"
export CXX="clang++"
export CC_LD="lld"
export CXX_LD="lld"

export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/

source $HOME/VulkanSDK/1.4.341.1/setup-env.sh >/dev/null
