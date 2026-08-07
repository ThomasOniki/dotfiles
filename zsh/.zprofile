source <(/opt/homebrew/bin/brew shellenv zsh)

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
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

use_brew_llvm_compilation_binaries() {
	export AS="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-as" CC="$HOMEBREW_PREFIX/opt/llvm/bin/clang" CXX="$HOMEBREW_PREFIX/opt/llvm/bin/clang++"
	export AR="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ar" CMAKE_AR="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ar" RANLIB="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ranlib"
	export LD="$HOMEBREW_PREFIX/opt/lld/bin/lld" CC_LD="$HOMEBREW_PREFIX/opt/lld/bin/lld" CXX_LD="$HOMEBREW_PREFIX/opt/lld/bin/lld" CMAKE_LINKER_TYPE="LLD"
	export STRIP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-strip"
	export OBJDUMP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-objdump" NM="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-nm"
}
use_system_compilation_binaries() {
	export AS="/usr/bin/as" CC="/usr/bin/clang" CXX="/usr/bin/clang++"
	export AR="/usr/bin/ar" CMAKE_AR="/usr/bin/ar" RANLIB="/usr/bin/ranlib"
	export LD="/usr/bin/ld" CC_LD="/usr/bin/ld" CXX_LD="/usr/bin/ld" CMAKE_LINKER_TYPE="SYSTEM"
	export STRIP="/usr/bin/strip"
	export OBJDUMP="/usr/bin/objdump" NM="/usr/bin/nm"
}

use_brew_llvm_compilation_binaries

export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/

source $HOME/VulkanSDK/1.4.341.1/setup-env.sh >/dev/null

export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
