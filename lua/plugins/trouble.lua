local function config()
  require('trouble').setup()
end

return { 'folke/trouble.nvim', dependencies = 'nvim-tree/nvim-web-devicons', config = config }
