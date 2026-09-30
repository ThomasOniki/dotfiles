---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, { "windwp/nvim-autopairs", opts = {} })

table.insert(spec, {
  "nvim-mini/mini.icons",
  opts = {
    extension = {
      mcfunction = { glyph = "󰍳" },
    },
  },
  config = function(_, opts)
    require("mini.icons").setup(opts)
    MiniIcons.mock_nvim_web_devicons()
  end,
})

table.insert(spec, {
  "akinsho/bufferline.nvim",
  opts = {},
  dependencies = {
    "nvim-mini/mini.icons",
  },
})

table.insert(spec, {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  opts = { icons_enabled = true },
})

table.insert(spec, {
  "numToStr/Comment.nvim",
  opts = {
    toggler = { line = "<leader>c", block = "gcb" },
  },
  keys = { "<leader>c" },
})

table.insert(spec, {
  "kevinhwang91/nvim-ufo",
  dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig", "kevinhwang91/promise-async" },
  opts = {},
  keys = { "za", "zR", "zM" },
})

table.insert(spec, {
  "rcarriga/nvim-notify",
  config = function()
    vim.notify = require("notify")
  end,
})

table.insert(spec, {
  "lewis6991/gitsigns.nvim",
  opts = {},
  keys = {
    {
      "<leader>gs",
      function()
        require("gitsigns").stage_hunk()
      end,
      desc = "Stage git hunk",
    },
    {
      "<leader>gu",
      function()
        require("gitsigns").stage_hunk()
      end,
      desc = "Unstage git hunk",
    },
  },
  event = "VeryLazy",
})

table.insert(spec, {
  "3rd/image.nvim",
  opts = {},
  enabled = not vim.g.neovide,
  event = "VeryLazy",
})

table.insert(spec, {
  "jghauser/follow-md-links.nvim",
})
table.insert(spec, {
  "OXY2DEV/markview.nvim",
  dependencies = { "jghauser/follow-md-links.nvim", "nvim-mini/mini.icons" },
  opts = {
    preview = { icon_provider = "mini" },
  },
})

table.insert(spec, {
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
})

table.insert(spec, {
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
})

table.insert(spec, {
  "willothy/flatten.nvim",
  opts = {},
})

return spec
