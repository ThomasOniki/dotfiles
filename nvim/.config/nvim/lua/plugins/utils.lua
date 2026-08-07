---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, { "akinsho/bufferline.nvim", opts = {} })
table.insert(spec, { "nvim-mini/mini.icons", opts = {} })
table.insert(spec, { "windwp/nvim-autopairs", opts = {} })

table.insert(spec, {
	"numToStr/Comment.nvim",
	opts = {
		toggler = { line = "<leader>c", block = "gcb" },
	},
	keys = { "<leader>c" },
})

table.insert(spec, {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
})

table.insert(spec, {
	"rcarriga/nvim-notify",
	config = function()
		vim.notify = require("notify")
	end,
})

table.insert(spec, {
	"3rd/image.nvim",
	opts = {},
	enabled = not vim.g.neovide,
})

table.insert(spec, {
	"OXY2DEV/markview.nvim",
	dependencies = { "nvim-mini/mini.icons" },
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
	"rmagatti/auto-session",
	dependencies = {},
	opts = {
		auto_restore_last_session = true,
		auto_delete_empty_sessions = false,
		session_lens = {
			picker = "fzf",
		},
	},
})

return spec
