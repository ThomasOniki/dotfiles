local schemes = {
  ayu = "Shatur/neovim-ayu",
  edge = "sainnhe/edge",
  tokyonight = "folke/tokyonight.nvim",
  dracula = "mofiqul/dracula.nvim",
  kanagawa = "rebelot/kanagawa.nvim",
  onedark = "olimorris/onedarkpro.nvim",
  nightfox = "EdenEast/nightfox.nvim",
  vscode = "Mofiqul/vscode.nvim",
  ["rose-pine"] = "rose-pine/neovim",
}

local specs = {}
local names = {}
for name, spec in pairs(schemes) do
  if type(spec) == "string" then
    spec = { spec }
  end
  table.insert(specs, spec)
  table.insert(names, name)
end

local function pick()
  math.randomseed(os.time())
  return names[math.random(1, #names)]
end

return {
  pick = pick,
  specs = specs,
}
