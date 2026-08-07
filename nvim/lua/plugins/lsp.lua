local function configure_lsps()
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})

	vim.lsp.config("clangd", {
		cmd = { "clangd", "--header-insertion=never", "--function-arg-placeholders=0" },
	})
end

---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
	"mason-org/mason.nvim",
	opts_extend = { "ensure_installed" },
	opts = {
		ensure_installed = {
			"clangd",
			"rust-analyzer",
			"lua-language-server",
			"bash-language-server",
			"pyright",
			"ruff",
			"jdtls",
			"mesonlsp",
		},
	},
})

table.insert(spec, {
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		"ibhagwan/fzf-lua",
	},
	opts = {
		picker = "fzf-lua",
	},
	event = "LspAttach",
})

table.insert(spec, {
	"neovim/nvim-lspconfig",
	config = configure_lsps,
	keys = {
		{ "<leader>ld", vim.lsp.buf.definition, desc = "Go to definition" },
		{ "<leader>lk", vim.lsp.buf.hover, desc = "Show hover info" },
		{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename symbol" },
		{
			"<leader>lc",
			function()
				require("tiny-code-action").code_action()
			end,
			desc = "LSP code action",
		},
		{
			"<leader>lh",
			function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end,
			desc = "Toggle LSP inlay hints",
		},
	},
	dependencies = {
		"rachartier/tiny-code-action.nvim",
	},
})

table.insert(spec, {
	"mason-org/mason-lspconfig.nvim",
	opts = {},
	dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
	},
})

return spec
