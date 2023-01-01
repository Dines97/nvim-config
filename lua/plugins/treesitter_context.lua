local function config()
  require('treesitter-context').setup()
end

return { 'nvim-treesitter/nvim-treesitter-context', dependencies = 'nvim-treesitter', config = config }
