local function lualine_config()
  local opts = {
    options = {
      globalstatus = true,
      theme = 'onedark',
      section_separators = '',
      component_separators = ''
    },
    sections = {
      lualine_b = { 'branch', 'diff',
        { 'diagnostics', symbols = { error = 'e', warn = 'w', info = 'i', hint = 'h' } } },
      lualine_x = { 'encoding', { 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' } }, 'filetype' }
    }
  }

  require('lualine').setup(opts)
end

return { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = lualine_config }
