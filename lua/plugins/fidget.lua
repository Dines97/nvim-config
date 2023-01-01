local function config()
  require('fidget').setup {
    text = {
      spinner = "dots", -- animation shown when tasks are ongoing
    }
  }
end

return { 'j-hui/fidget.nvim', config = config }
