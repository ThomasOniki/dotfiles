return {
  { "akinsho/bufferline.nvim", opts = {} },
  { "nvim-mini/mini.icons", opts = {} },
  { "windwp/nvim-autopairs", opts = {} },

  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = { line = "<leader>c", block = "gcb" },
    },
    keys = { "<leader>c" },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },

  {
    "3rd/image.nvim",
    opts = {},
    enabled = not vim.g.neovide,
  },

  {
    "OXY2DEV/markview.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
      preview = { icon_provider = "mini" },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      spec = {
        { "<leader>", group = "leader" },
        { "<leader>f", group = "search" },
        { "<leader>l", group = "lsp" },
        { "<leader>d", group = "debugger" },
      },
    },
  },

  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    opts = {
      mappings = {
        i = {
          t = { n = "<esc>" },
        },
        c = {
          t = { n = "<C-c>" },
        },
        t = {
          t = { n = "<C-\\><C-n>" },
        },
      },
    },
  },
  {
    "rmagatti/auto-session",
    opts = {
      auto_restore_last_session = true,
      auto_delete_empty_sessions = false,
      session_lens = {
        picker = "fzf",
      },
    },
  },
}
