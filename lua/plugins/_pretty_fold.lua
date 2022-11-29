local function config()
  require("pretty-fold").setup()
  require("pretty-fold.preview").setup()
end

return { 'anuvyklack/pretty-fold.nvim', requires = 'anuvyklack/nvim-keymap-amend', config = config }
