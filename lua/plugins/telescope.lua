local function config()
  require('telescope').setup()
end

return { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim', config = config }
