local function config()
  require('trouble').setup()
end

return { 'folke/trouble.nvim', dependencies = 'kyazdani42/nvim-web-devicons', config = config }
