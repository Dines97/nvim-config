local function config()
  local mappings = {
    m = { '<cmd>Mason<cr>', "Mason" },
  }

  local mappings_opts = {
    mode = 'n',
    prefix = '<leader>',
    buffer = bufnr,
    silent = true,
    noremap = true,
  }

  require("which-key").register(mappings, mappings_opts)

  require('mason').setup()
end

return {
  "williamboman/mason.nvim",
  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
      config = true
    },
    'folke/which-key.nvim',
  },
  config = config,
}
