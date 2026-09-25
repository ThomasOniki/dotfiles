source <(/opt/homebrew/bin/brew shellenv zsh)

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

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

# This is to make emscan-deps not report an error there is no bundled clang-scan-deps in the
# default emscripten llvm. To get the emscripten-llvm-bin directory, run:
#
# brew install llvm lld
# [[ -z XDG_DATA_HOME ]] && XDG_DATA_HOME="$HOME/.local/share"
# export EM_LLVM_ROOT="$XDG_DATA_HOME/emscripten-llvm-bin"
# mkdir -p "$EM_LLVM_ROOT"
# ln -s "$HOMEBREW_PREFIX/opt/llvm/bin/clang" "$EM_LLVM_ROOT"
# ln -s "$HOMEBREW_PREFIX/opt/llvm/bin/clang++" "$EM_LLVM_ROOT"
# ln -s "$HOMEBREW_PREFIX/opt/llvm/bin/clang-scan-deps" "$EM_LLVM_ROOT"
# ln -s "$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ar" "$EM_LLVM_ROOT"
# ln -s "$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ranlib" "$EM_LLVM_ROOT"
# ln -s "$HOMEBREW_PREFIX/opt/llvm/bin/llvm-objcopy" "$EM_LLVM_ROOT"
# ln -s "$HOMEBREW_PREFIX/opt/lld/bin/lld" "$EM_LLVM_ROOT/wasm-ld"
export EM_LLVM_ROOT="$XDG_DATA_HOME/emscripten-llvm-bin/"

PATH="$HOME/.local/bin:$PATH"
PATH="$HOMEBREW_PREFIX/bin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/rustup/bin:$PATH"
export PATH

export MANPATH="$XDG_CACHE_HOME/cppman:$MANPATH"

export EDITOR="nvim"
export LESSUTFCHARDEF='E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p'
export PAGER="bat"
export MANPAGER="nvim -c Man!"
export BAT_STYLE="plain"

export AS="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-as" CC="$HOMEBREW_PREFIX/opt/llvm/bin/clang" CXX="$HOMEBREW_PREFIX/opt/llvm/bin/clang++"
export AR="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ar" RANLIB="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-ranlib"
export LD="lld" CC_LD="lld" CXX_LD="lld"
export STRIP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-strip"
export OBJDUMP="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-objdump" NM="$HOMEBREW_PREFIX/opt/llvm/bin/llvm-nm"
export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/
export CLANGD="$HOMEBREW_PREFIX/opt/llvm/bin/clangd"
export CFLAGS="-pipe" CXXFLAGS="-pipe" OBJCFLAGS="-pipe" OBJCXXFLAGS="-pipe"

export CMAKE_EXPORT_COMPILE_COMMANDS=ON
export CMAKE_CXX_COMPILER_LAUNCHER="$HOMEBREW_PREFIX/opt/ccache/bin/ccache"
export CMAKE_GENERATOR="Ninja Multi-Config"

export CMAKE_CONFIGURATION_TYPES="ASan;Native;Debug;Release;RelWithDebInfo"
export CMAKE_C_FLAGS_ASAN="-g -O0 -fsanitize=address,undefined"
export CMAKE_CXX_FLAGS_ASAN="-g -O0 -fsanitize=address,undefined"
export CMAKE_OBJC_FLAGS_ASAN="-g -O0 -fsanitize=address,undefined"
export CMAKE_OBJCXX_FLAGS_ASAN="-g -O0 -fsanitize=address,undefined"
export CMAKE_C_FLAGS_NATIVE="-O3 -DNDEBUG -march=native"
export CMAKE_CXX_FLAGS_NATIVE="-O3 -DNDEBUG -march=native"
export CMAKE_OBJC_FLAGS_NATIVE="-O3 -DNDEBUG -march=native"
export CMAKE_OBJCXX_FLAGS_NATIVE="-O3 -DNDEBUG -march=native"

source $HOME/VulkanSDK/1.4.341.1/setup-env.sh >/dev/null
