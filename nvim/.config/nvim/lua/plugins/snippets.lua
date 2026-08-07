---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  event = "VeryLazy",
  opts = {},
})

return spec
