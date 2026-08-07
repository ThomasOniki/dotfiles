---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
	"saghen/blink.cmp",
	event = "VeryLazy",
	build = "cargo build --release",
	dependencies = { "L3MON4D3/LuaSnip" },
	opts = {
		sources = { default = { "lsp", "snippets", "buffer", "path" } },
		snippets = { preset = "luasnip" },
		signature = { enabled = true },
		fuzzy = { implementation = "rust" },
		keymap = {
			["<tab>"] = { "select_next", "fallback" },
			["<s-tab>"] = { "select_prev", "fallback" },
		},
		completion = {
			menu = { auto_show = true },
			documentation = { auto_show = true, auto_show_delay_ms = 0 },
			list = { selection = { preselect = false } },
		},

		cmdline = {
			keymap = { preset = "inherit" },
			completion = {
				menu = { auto_show = true },
				list = { selection = { preselect = false } },
			},
		},
	},
})

return spec
