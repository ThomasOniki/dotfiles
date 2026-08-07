---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
  "rmagatti/auto-session",
  dependencies = {},
  opts = {
    auto_restore_last_session = not vim.g.do_not_restore_last_session,
    auto_delete_empty_sessions = false,
    session_lens = {
      picker = "fzf",
    },
  },
})

return spec
