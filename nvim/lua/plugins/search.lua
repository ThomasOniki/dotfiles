---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-mini/mini.icons" },
	opts = { grep = { rg_opts = "--color=always --line-number --column --hidden" } },
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
			"<leader>fs",
			function()
				require("auto-session").search()
			end,
			desc = "Find session",
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
