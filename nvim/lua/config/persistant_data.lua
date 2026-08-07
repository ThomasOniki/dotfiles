local file = vim.fn.stdpath("data") .. "/persistant_data.txt"
local data = {}

if vim.fn.filereadable(file) == 1 then
  local raw = vim.fn.readfile(file)
  local key
  for idx, value in ipairs(raw) do
    if idx % 2 == 0 then
      key = value
    else
      data[key] = value
    end
  end
else
  data = {}
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    local raw = {}
    for key, value in ipairs(data) do
      table.insert(raw, key)
      table.insert(raw, value)
    end
    vim.fn.writefile(raw, file)
  end,
})

return data
