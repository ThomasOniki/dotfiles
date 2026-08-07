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

---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
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
})

table.insert(spec, {
  "neovim/nvim-lspconfig",
  config = configure_lsps,
})

table.insert(spec, {
  "mason-org/mason-lspconfig.nvim",
  opts = {},
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
})

return spec
