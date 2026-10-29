export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

source "$XDG_CONFIG_HOME/zsh/toolchains.zsh"

[ -x /opt/homebrew/bin/brew ] && source <(/opt/homebrew/bin/brew shellenv zsh)
if [ -n "$HOMEBREW_PREFIX" ]; then
	export WINEPATH="$HOMEBREW_PREFIX/opt/mingw-w64/toolchain-x86_64/x86_64-w64-mingw32/bin;$HOMEBREW_PREFIX/opt/mingw-w64/toolchain-x86_64/x86_64-w64-mingw32/lib"
	export WINEDEBUG="-all"

	PATH="$HOMEBREW_PREFIX/bin:$PATH"
	PATH="$HOMEBREW_PREFIX/opt/rustup/bin:$PATH"
	export PATH

	[ -d "$HOMEBREW_PREFIX/opt/llvm" ] && use_brew_llvm_toolchain
fi

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export SHELL_SESSIONS_DISABLE=1
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"

PATH="$HOME/.local/bin:$PATH"
PATH="$PYTHONUSERBASE/bin:$PATH"
PATH="$CARGO_HOME/bin:$PATH"
PATH="$GOBIN:$PATH"
export PATH

export MANPATH="$XDG_CACHE_HOME/cppman:$MANPATH"

export EDITOR="nvim"
export LESSUTFCHARDEF='E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p'
export PAGER="bat"
export MANPAGER="nvim -c Man!"
export BAT_STYLE="plain"
