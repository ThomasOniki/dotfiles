---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config
  opts = {
    "fzf-tmux",
    grep = { rg_opts = "--color=always --line-number --column --hidden" },
  },
  keys = {
    {
      "<leader>ff",
      function()
        FzfLua.files()
      end,
      desc = "Find file",
    },
    {
      "<leader>fg",
      function()
        FzfLua.live_grep()
      end,
      desc = "Grep files",
    },
    {
      "<leader>fb",
      function()
        FzfLua.buffers()
      end,
      desc = "Find open buffer",
    },
    {
      "<leader>fh",
      function()
        FzfLua.oldfiles()
      end,
      desc = "Find recent file",
    },
    {
      "<leader>f*",
      function()
        FzfLua.grep_cword()
      end,
      desc = "Grep for current word",
    },
    {
      "<C-f>",
      function()
        require("fzf-lua").fzf_exec("tmux list-sessions -F '#{session_name}'", {
          actions = {
            ["default"] = function(selected)
              os.execute("tmux switch-client -t " .. selected[1])
            end,
          },
        })
      end,
    },
  },

  event = "VeryLazy",
})

table.insert(spec, {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>fr",
      function()
        require("grug-far").open()
      end,
      desc = "Find and replace...",
    },
  },
  event = "VeryLazy",
  opts = {
    enabledEngines = { "ripgrep" },
    engines = {
      ripgrep = {
        extraArgs = "--hidden",
      },
    },
  },
})

return spec
