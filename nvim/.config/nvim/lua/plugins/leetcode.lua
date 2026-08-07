---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "ibhagwan/fzf-lua",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  ---@type lc.UserConfig
  opts = {
    picker = { provider = "fzf-lua" },

    ---@type table<lc.lang, lc.inject>
    injector = {
      ["python3"] = {
        imports = function(default_imports)
          vim.list_extend(default_imports, { "from .leetcode import *" })
          return default_imports
        end,
        after = { "def test():", "    print('test')" },
      },
      ["cpp"] = {
        imports = function()
          -- return a different list to omit default imports
          return { "#include <vector>", "#include <string>", "using namespace std;" }
        end,
        after = "int main() {}",
      },
    },
  },
})

return spec
