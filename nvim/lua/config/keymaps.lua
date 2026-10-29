vim.g.mapleader = " "

---@type { [string]: LazyKeysSpec[] }
local mappings = {}

mappings.default = {
  { "<leader>p", '"_dP', desc = "Paste without coping overwritten text", mode = "x" },
  { "<esc>", "<Esc><cmd>noh<CR>", desc = "Escape and :noh", mode = { "n", "i", "x" } },
  { "<leader>w", "<cmd>up<CR>", desc = "Save buffer" },
  { "<leader>W", "<cmd>wa<CR>", desc = "Save all buffers" },
  { "<leader>x", "<cmd>up|bd<CR>", desc = "Save and close buffer" },
  { "<leader>X", "<cmd>bw!<CR>", desc = "Force quit buffer without saving" },
  { "<leader>q", "<cmd>wqa<CR>", desc = "Save and close all buffers" },
  { "<leader>Q", "<cmd>qa!<CR>", desc = "Force quit all buffers without saving" },
  { "<D-v>", '"*p', desc = "Paste from clipboard" },
  {
    "<esc>",
    function()
      vim.notify(
        "Use jk, jj, or tn to exit insert mode. You can disable this keymap near the end of lua/config/keymaps.lua."
      )
    end,
    mode = "i",
  },
  {
    "<leader>h",
    function()
      vim.diagnostic.open_float()
    end,
  },
}

mappings.colemak = {
  { "n", "h", desc = "Left", mode = { "n", "x" } },
  { "i", "l", desc = "Right", mode = { "n", "x" } },
  { "u", "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Up", mode = { "n", "x" } },
  { "e", "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Down", mode = { "n", "x" } },
  { "m", "g^", desc = "Start of line (non ws)", mode = { "n", "x" } },
  { "o", "g$", desc = "End of line", mode = { "n", "x" } },
  { "t", "W", desc = "Next WORD", mode = { "n", "x" } },
  { "T", "w", desc = "Next word", mode = { "n", "x" } },
  { "r", "B", desc = "Prev WORD", mode = { "n", "x" } },
  { "R", "b", desc = "Prev word", mode = { "n", "x" } },
  { "a", "i", desc = "Insert", mode = { "n", "x" } },
  { "w", "a", desc = "Append", mode = { "n", "x" } },
  { "q", "u", desc = "Undo", mode = { "n", "x" } },
  { "h", ":", desc = "Cmd mode", mode = { "n", "x" } },
  { "<leader>n", "<cmd>bp<CR>", desc = "Prev buffer" },
  { "<leader>i", "<cmd>bn<CR>", desc = "Next buffer" },
  { "<leader>m", "q", desc = "Record macro" },
}

local function map(list)
  for _, entry in ipairs(mappings[list]) do
    local opts = {}
    for key, value in pairs(entry) do
      if type(key) == "string" and key ~= "mode" then
        opts[key] = value
      end
    end
    vim.keymap.set(entry.mode or "n", entry[1], entry[2], opts)
  end
end

local function unmap(list)
  for _, entry in ipairs(mappings[list]) do
    local opts = {}
    for key, value in pairs(entry) do
      if type(key) == "string" then
        opts[key] = value
      end
    end
    vim.keymap.del(entry.mode or "n", entry[1], opts)
  end
end

vim.api.nvim_create_user_command("UseColemakKeymaps", function()
  map("colemak")
end, { desc = "Remap keys for colemak dh" })

vim.api.nvim_create_user_command("UseQwertyKeymaps", function()
  unmap("colemak")
end, { desc = "Remap keys for qwerty" })

map("default")

return { map = map, unmap = unmap }
