if command -v ccache >/dev/null; then
	export CMAKE_C_COMPILER_LAUNCHER=ccache
	export CMAKE_CXX_COMPILER_LAUNCHER=ccache
	export CMAKE_OBJC_COMPILER_LAUNCHER=ccache
	export CMAKE_OBJCXX_COMPILER_LAUNCHER=ccache
fi
