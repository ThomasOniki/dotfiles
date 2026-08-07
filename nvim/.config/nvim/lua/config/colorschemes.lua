local M = {}

M.edge = function()
	vim.g.edge_style = "default"
	vim.g.edge_enable_italic = 1
	vim.g.edge_better_performance = 1

	vim.cmd.colorscheme("edge")
end

return M
