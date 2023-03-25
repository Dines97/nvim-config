local function config()
  local opts = {
    style = 'darker',
    transparent = false,
    code_style = {
      comments = 'none',
      keywords = 'italic',
      functions = 'none',
      strings = 'none',
      variables = 'none'
    }
  }

  require('onedark').setup(opts)
  require('onedark').load()
end

return { 'navarasu/onedark.nvim', config = config }
