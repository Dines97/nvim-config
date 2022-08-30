local function config()
  local opts = {
    show_current_context = true,
    show_current_context_start = true
  }

  require("indent_blankline").setup(opts)
end

return { 'lukas-reineke/indent-blankline.nvim', config = config }
