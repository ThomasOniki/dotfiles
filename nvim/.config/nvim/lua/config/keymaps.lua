vim.g.mapleader = " "

local map = vim.keymap.set
local unmap = vim.keymap.del

local function map_colemak()
	map({ "n", "v" }, "n", "h", { desc = "Left" })
	map({ "n", "v" }, "i", "l", { desc = "Right" })
	map({ "n", "v" }, "u", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up" })
	map({ "n", "v" }, "e", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down" })

	map({ "n", "v" }, "m", "g^", { desc = "Start of line (non ws)" })
	map({ "n", "v" }, "o", "g$", { desc = "End of line" })

	map({ "n", "v" }, "t", "W", { desc = "Next WORD" })
	map({ "n", "v" }, "T", "w", { desc = "Next word" })
	map({ "n", "v" }, "r", "B", { desc = "Prev WORD" })
	map({ "n", "v" }, "R", "b", { desc = "Prev word" })

	map({ "n", "v" }, "a", "i", { desc = "Insert" })
	map({ "n", "v" }, "w", "a", { desc = "Append" })

	map({ "n", "v" }, "q", "u", { desc = "Undo" })

	map({ "n", "v" }, "h", ":", { desc = "Cmd mode" })

	map("n", "<leader>n", "<cmd>bp<CR>", { desc = "Prev buffer" })
	map("n", "<leader>i", "<cmd>bn<CR>", { desc = "Next buffer" })
end

local function unmap_colemak()
	unmap({ "n", "v" }, "n")
	unmap({ "n", "v" }, "i")
	unmap({ "n", "v" }, "u")
	unmap({ "n", "v" }, "e")

	unmap({ "n", "v" }, "m")
	unmap({ "n", "v" }, "o")

	unmap({ "n", "v" }, "t")
	unmap({ "n", "v" }, "T")
	unmap({ "n", "v" }, "r")
	unmap({ "n", "v" }, "R")

	unmap({ "n", "v" }, "a")
	unmap({ "n", "v" }, "w")

	unmap({ "n", "v" }, "q")

	unmap({ "n", "v" }, "h")

	unmap("n", "<leader>n")
	unmap("n", "<leader>i")
end

local function map_qwerty() end
local function unmap_qwerty() end

local M = {}
local is_colemak_mapped = false
local is_qwerty_mapped = false

M.colemak = function()
	if is_qwerty_mapped then
		unmap_qwerty()
		is_qwerty_mapped = false
	end

	if not is_colemak_mapped then
		map_colemak()
		is_colemak_mapped = true
	end
end

M.qwerty = function()
	if is_colemak_mapped then
		unmap_colemak()
		is_colemak_mapped = false
	end

	if not is_qwerty_mapped then
		map_qwerty()
		is_qwerty_mapped = true
	end
end

vim.api.nvim_create_user_command("UseColemakKeymaps", M.colemak, { desc = "Remap keys for colemak dh" })
vim.api.nvim_create_user_command("UseQwertyKeymaps", M.qwerty, { desc = "Remap keys for qwerty" })

map({ "v" }, "<leader>p", '"_dP', { desc = "Paste without coping overwritten text" })

map({ "n", "i", "s" }, "<Esc>", "<Esc><cmd>noh<CR>", { desc = "Escape and :noh" })

map("n", "<leader>w", "<cmd>up<CR>", { desc = "Save buffer" })
map("n", "<leader>W", "<cmd>wa<CR>", { desc = "Save all buffers" })
map("n", "<leader>x", "<cmd>up|bd<CR>", { desc = "Save and close buffer" })
map("n", "<leader>X", "<cmd>bw!<CR>", { desc = "Force quit buffer without saving" })
map("n", "<leader>q", "<cmd>wqa<CR>", { desc = "Save and close all buffers" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all buffers without saving" })

map("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>lk", vim.lsp.buf.hover, { desc = "Show hover info" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>lh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle LSP inlay hints" })

map("n", "<leader>t", "<cmd>term<CR>", { desc = "Open terminal buffer" })

map("i", "<esc>", function()
	vim.notify(
		"Use jk, jj, or tn to exit insert mode. You can disable this keymap near the end of lua/config/keymaps.lua."
	)
end)

map("n", "<D-v>", '"*p', { desc = "Paste from system" })

return M
