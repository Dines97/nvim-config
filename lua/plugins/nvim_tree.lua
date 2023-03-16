local function config()
  require('nvim-tree').setup()


  local mappings = {
    e = {
      name = 'Explorer',
      o = { '<cmd>NvimTreeOpen<cr>', 'Open explorer' },
      c = { '<cmd>NvimTreeClose<cr>', 'Close explorer' },
      r = { '<cmd>NvimTreeRefresh<cr>', 'Refresh explorer' }
    }
  }

  local mappings_opts = {
    mode = 'n', -- NORMAL mode
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true -- use `nowait` when creating keymaps
  }


  require('which-key').register(mappings, mappings_opts)
end

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = config,
  enabled = false
}
