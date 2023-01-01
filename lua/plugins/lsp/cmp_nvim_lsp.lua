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

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  -- require("lspconfig")["rnix"].setup(opts)
  require("lspconfig")["gopls"].setup(opts)
  require("lspconfig")["dockerls"].setup(opts)
  require("lspconfig")["yamlls"].setup(opts)
  -- require("lspconfig")["jedi_language_server"].setup(opts)
  require("lspconfig")["pyright"].setup(opts)
  require("lspconfig")["hls"].setup(opts)
  require("lspconfig")["nil_ls"].setup(opts)

  require("lspconfig")["sumneko_lua"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
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
  }

  require("lspconfig")["omnisharp"].setup {
    on_attach = on_attach,
    capabilities = capabilities,

    cmd = { "OmniSharp" },
    handlers = {
      ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
  }

  -- require("lspconfig")["volar"].setup {
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --
  --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
  -- }
  --
  require("lspconfig")["vuels"].setup {
    on_attach = on_attach,
    capabilities = capabilities,

    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
  }
end

return { 'hrsh7th/cmp-nvim-lsp', after = { 'which-key.nvim', 'nvim-lspconfig', 'neodev.nvim' },
  requires = { 'Hoffs/omnisharp-extended-lsp.nvim' }, config = config }
