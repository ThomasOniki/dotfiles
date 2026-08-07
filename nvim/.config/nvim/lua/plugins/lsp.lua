local function configure_lsps()
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })

  vim.lsp.config("clangd", {
    cmd = { "clangd", "--header-insertion=never", "--function-arg-placeholders=0" },
  })
end

return {
  {
    "mason-org/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "clangd",
        "rust-analyzer",
        "lua-language-server",
        "bash-language-server",
        "pyright",
        "ruff",
        "jdtls",
        "mesonlsp",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = configure_lsps,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
}
