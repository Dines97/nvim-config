local function config()
  require('nvim-tree').setup()
end

return { "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons", }, config = config }
