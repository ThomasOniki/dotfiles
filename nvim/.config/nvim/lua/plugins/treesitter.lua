---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
})

return spec
