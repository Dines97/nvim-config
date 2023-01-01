local function config()
  require('bufferline').setup()
end

return { 'akinsho/bufferline.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' }, config = config }
