local function config()
  require('treesitter-context').setup()
end

return { 'nvim-treesitter/nvim-treesitter-context', after = 'nvim-treesitter', config = config }
