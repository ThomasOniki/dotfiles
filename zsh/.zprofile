eval "$(/opt/homebrew/bin/brew shellenv zsh)"

PATH="$HOME/.local/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/opt/ccache/libexec:$PATH"
PATH="/opt/homebrew/opt/ruby/bin:$PATH"
PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
PATH="/opt/homebrew/opt/rustup/bin:$PATH"
PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH

export EDITOR="/opt/homebrew/bin/nvim"
export PAGER="/opt/homebrew/opt/page/bin/page -WfC -q 90000 -z 90000"
export MANPAGER="/opt/homebrew/opt/page/bin/page -t man"

export CC="/opt/homebrew/opt/llvm/bin/clang"
export CXX="/opt/homebrew/opt/llvm/bin/clang++"
export CC_LD="lld"
export CXX_LD="lld"

export ASAN_OPTIONS="detect_leaks=1"
export LSAN_OPTIONS="suppressions=$HOME/.lsan_suppressions"

source $HOME/VulkanSDK/1.4.341.1/setup-env.sh >/dev/null
