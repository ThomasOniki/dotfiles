---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  event = "VeryLazy",
  opts = {
    enable_autosnippets = true,
  },
  config = function(_, opts)
    require("luasnip").setup(opts)
    require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/lua/snippets" })
  end,
  keys = {
    {
      "<S-CR>",
      function()
        require("luasnip").jump(1)
      end,
      mode = { "i", "x" },
      desc = "Jump snippet",
    },
  },
})

return spec
