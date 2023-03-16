local function config()
  require('bufferline').setup()
end

return { 'akinsho/bufferline.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = config }
