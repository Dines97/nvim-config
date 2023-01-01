local function config()
  local opts = {
    include = { "go" }
  }

  require("luasnip.loaders.from_vscode").load(opts)
end

return { 'L3MON4D3/LuaSnip', config = config }
