local opts = {
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    objc = { "clang_format" },
    objcpp = { "clang_format" },
    cuda = { "clang_format" },

    lua = { "stylua" },

    cmake = { "cmake_format" },

    sh = { "shfmt" },
    zsh = { "shfmt" },
  },

  formatters = {
    clang_format = {
      prepend_args = { "--style=file" },
    },
    stylua = {
      prepend_args = {
        "--indent-type",
        "Spaces",
        "--indent-width",
        "2",
      },
    },
    cmake_format = {},
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return {
  {
    "mason-org/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "clang-format",
        "stylua",
        "shfmt",
        "cmakelang",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = opts,
    event = "BufWritePre",
  },
}
