if [ -z "$XDG_RUNTIME_DIR" ]; then
	export XDG_RUNTIME_DIR="/tmp/$UID-runtime-dir"
	mkdir -pm 0700 "$XDG_RUNTIME_DIR"
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

PATH="$PYTHONUSERBASE/bin:$PATH"
PATH="$CARGO_HOME/bin:$PATH"
PATH="$GOBIN:$PATH"
export PATH
