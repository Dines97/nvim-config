local function config()
  local function on_attach(client, bufnr)
    require('notify')('LSP attached')

    local mappings = {
      l = {
        f = { function() vim.lsp.buf.format({ async = true }) end, 'Format' }
      }
    }

    local mappings_opts = {
      mode = 'n',
      prefix = '<leader>',
      buffer = bufnr,
      silent = true,
      noremap = true
    }

    require('which-key').register(mappings, mappings_opts)
  end

  local servers = {
    gopls = {},
    dockerls = {},
    yamlls = {},
    pyright = {},
    hls = {},
    nil_ls = {},
    lua_ls = {
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
            library = {
              '/run/current-system/sw/share/awesome/lib'
            }
          },
          diagnostics = {
            globals = { 'vim' }
          },
          format = {
            enable = true,
            -- Put format options here
            -- NOTE: the value should be STRING!!
            defaultConfig = {
              indent_style = 'space',
              indent_size = '2',

              quote_style = 'single',
              trailing_table_separator = 'never'
            }
          }
        }
      }
    },
    omnisharp = {
      cmd = { 'OmniSharp' },
      handlers = {
        ['textDocument/definition'] = require('omnisharp_extended').handler
      }
    }
    -- volar = {
    --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
    -- },
    -- vuels = {
    --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
    -- },
    -- rnix = {},
    -- jedi_language_server = {}
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  for server, opts in pairs(servers) do
    opts.capabilities = capabilities
    opts.on_attach = on_attach
    require('lspconfig')[server].setup(opts)
  end
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'folke/neodev.nvim', config = true },
    'Hoffs/omnisharp-extended-lsp.nvim',
    'folke/which-key.nvim'
  },
  config = config
}
