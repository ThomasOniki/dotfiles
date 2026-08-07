---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").asciidoc = {
			install_info = {
				url = "https://github.com/cathaysia/tree-sitter-asciidoc",
				branch = "master",
				location = "tree-sitter-asciidoc",
				generate = true,
				generate_from_json = true,
			},
		}
		require("nvim-treesitter.parsers").asciidoc_inline = {
			install_info = {
				url = "https://github.com/cathaysia/tree-sitter-asciidoc",
				branch = "master",
				location = "tree-sitter-asciidoc_inline",
				generate = true,
				generate_from_json = true,
			},
		}
	end,
})

return spec
