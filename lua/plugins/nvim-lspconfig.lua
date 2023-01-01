local function config()
  local function on_attach(client, bufnr)
    require("notify")("LSP attached")

    local mappings = {
      l = {
        f = { function() vim.lsp.buf.format({ async = true }) end, "Format" },
        d = { function() vim.lsp.buf.definition() end, "Definition" },
        q = { function() vim.lsp.buf.code_action() end, "Quick fix" },
        r = { function() vim.lsp.buf.rename() end, "Rename" }
      }
    }

    local mappings_opts = {
      mode = 'n',
      prefix = '<leader>',
      buffer = bufnr,
      silent = true,
      noremap = true,
    }

    require("which-key").register(mappings, mappings_opts)
  end

  local servers = {
    gopls = {},
    dockerls = {},
    yamlls = {},
    pyright = {},
    hls = {},
    nil_ls = {},
    sumneko_lua = {
      settings = {
        Lua = {
          workspace = {
            library = {
              '/run/current-system/sw/share/awesome/lib'
            },
          },
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    },
    omnisharp = {

      cmd = { "OmniSharp" },
      handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
      },
    },
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
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  for server, opts in pairs(servers) do
    opts.capabilities = capabilities
    opts.on_attach = on_attach
    require("lspconfig")[server].setup(opts)
  end
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'folke/neodev.nvim', config = true },
    'Hoffs/omnisharp-extended-lsp.nvim',
    {
      "williamboman/mason.nvim",
      config = true,
    },
    { "williamboman/mason-lspconfig.nvim", config = { automatic_installation = true } },
    'folke/which-key.nvim',
  },
  config = config
}
