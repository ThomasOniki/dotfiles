FzfLua = {}

local fzf_keys = {
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
    "<leader>fs",
    function()
      require("auto-session").search()
    end,
    desc = "Find session",
  },
}

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-mini/mini.icons", "rmagatti/auto-session" },
    opts = { grep = { rg_opts = "--color=always --line-number --column --hidden" } },
    keys = fzf_keys,
    cmd = { "FzfLua" },
  },
  {
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
  },
}
