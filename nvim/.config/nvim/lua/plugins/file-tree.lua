local opts = {
  enable_cursor_hijack = true,

  commands = {
    colemak_up = function()
      vim.api.nvim_feedkeys("k", "n", false)
    end,

    colemak_down = function()
      vim.api.nvim_feedkeys("j", "n", false)
    end,
  },

  window = {
    mappings = {
      ["u"] = "colemak_up",
      ["e"] = "colemak_down",
      ["j"] = "none",
      ["k"] = "none",
    },
  },

  filesystem = {
    filtered_items = {
      visible = false, -- hide filtered items on open
      hide_gitignored = true,
      hide_dotfiles = false,
      hide_by_name = {
        ".github",
        ".gitignore",
        "package-lock.json",
        ".changeset",
        ".prettierrc.json",
      },
      never_show = { ".git" },
    },
  },
}

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "antosha417/nvim-lsp-file-operations",
    },
    opts = opts,
    keys = {
      { "<leader>e", "<cmd>Neotree toggle dir=<CR>", desc = "Toggle neotree" },
    },
  },
}
