---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "ibhagwan/fzf-lua",
  },
  cmd = "Neogit",

  keys = {
    {
      "<leader>gg",
      function()
        require("neogit").open()
      end,
      desc = "Show Neogit UI",
    },
  },

  opts = {
    mappings = {
      status = {
        ["e"] = "MoveDown",
        ["u"] = "MoveUp",
        ["o"] = "OpenTree",
        ["q"] = "Close",
        ["I"] = "InitRepo",
        ["1"] = "Depth1",
        ["2"] = "Depth2",
        ["3"] = "Depth3",
        ["4"] = "Depth4",
        ["Q"] = "Command",
        ["<tab>"] = "Toggle",
        ["X"] = "Discard",
        ["s"] = "Stage",
        ["S"] = "StageUnstaged",
        ["<c-s>"] = "StageAll",
        ["x"] = "Unstage",
        ["K"] = "Untrack",
        ["U"] = "UnstageStaged",
        ["y"] = "ShowRefs",
        ["$"] = "CommandHistory",
        ["Y"] = "YankSelected",
        ["gp"] = "GoToParentRepo",
        ["<c-r>"] = "RefreshBuffer",
        ["<cr>"] = "GoToFile",
        ["<s-cr>"] = "PeekFile",
        ["<c-v>"] = "VSplitOpen",
        ["<c-x>"] = "SplitOpen",
        ["<c-t>"] = "TabOpen",
        ["{"] = "GoToPreviousHunkHeader",
        ["}"] = "GoToNextHunkHeader",
        ["[c"] = "OpenOrScrollUp",
        ["]c"] = "OpenOrScrollDown",
        ["<c-k>"] = "PeekUp",
        ["<c-j>"] = "PeekDown",
      },
    },
  },
})

return spec
