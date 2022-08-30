local function config()
  require('Comment').setup()
end

return { 'numToStr/Comment.nvim', config = config }
