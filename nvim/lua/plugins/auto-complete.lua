---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
  "saghen/blink.cmp",
  event = "VeryLazy",
  dependencies = { "L3MON4D3/LuaSnip" },
  version = "1.10.2",
  opts = {
    sources = { default = { "lsp", "snippets", "buffer", "path", "omni" } },
    snippets = { preset = "luasnip" },
    signature = { enabled = true },
    fuzzy = { implementation = "rust" },
    keymap = {
      preset = "none",
      ["<tab>"] = { "select_next", "fallback" },
      ["<s-tab>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-c>"] = { "cancel", "fallback" },
    },
    completion = {
      menu = { auto_show = true },
      documentation = { auto_show = true, auto_show_delay_ms = 0 },
      list = {
        selection = { auto_insert = false },
      },
    },
    cmdline = {
      keymap = { preset = "inherit" },
      completion = {
        menu = { auto_show = true },
        list = {
          selection = { auto_insert = false },
        },
      },
    },
  },
})

return spec
