---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
  "azratul/live-share.nvim",
  opts = {
    username = vim.g.live_share_username or "default_user",
  },
  config = function(_, opts)
    require("live-share").setup(opts)
    if opts.username == "host" then
      vim.cmd("LiveShareHostStart")
    end
  end,
  event = "VeryLazy",
})

return spec
