---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
  "rmagatti/auto-session",
  dependencies = {},
  opts = {
    auto_delete_empty_sessions = false,
    session_lens = {
      picker = "fzf",
    },
  },
})

return spec
