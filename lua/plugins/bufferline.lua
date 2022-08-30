local function config()
  require("bufferline").setup()
end

return { 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons' }, config = config }
