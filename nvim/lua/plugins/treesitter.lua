---@type LazyPluginSpec[]
local spec = {}

table.insert(spec, {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    vim.treesitter.language.register("bash", "sh")
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    local parsers = require("nvim-treesitter.parsers")
    parsers.asciidoc = {
      install_info = {
        url = "https://github.com/cathaysia/tree-sitter-asciidoc",
        branch = "master",
        location = "tree-sitter-asciidoc",
        generate = true,
        generate_from_json = true,
        revision = "64617307736c1c16b07537810b28ce6098a64066",
      },
      tier = 1,
    }
    parsers.asciidoc_inline = {
      install_info = {
        url = "https://github.com/cathaysia/tree-sitter-asciidoc",
        branch = "master",
        location = "tree-sitter-asciidoc_inline",
        generate = true,
        generate_from_json = true,
        revision = "64617307736c1c16b07537810b28ce6098a64066",
      },
      tier = 2,
    }
    parsers.mcfunction = {
      install_info = {
        url = "https://github.com/bbfh-dev/tree-sitter-mcfunction",
        branch = "main",
        queries = "queries/mcfunction",
        revision = "6015276e6f42767fb2f5b07b463260a16a0d9a73",
      },
      tier = 2,
    }
  end,
})

vim.filetype.add({
  extension = {
    ["mcfunction"] = "mcfunction",
  },
})

return spec
