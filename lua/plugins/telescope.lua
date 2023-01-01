local function config()
  require('telescope').setup()
end

return { 'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim', config = config }
