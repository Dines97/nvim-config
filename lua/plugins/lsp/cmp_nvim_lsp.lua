local function config()
  local function on_attach(client, bufnr)
    require("notify")("LSP attached")

    local mappings = {
      l = {
        f = { function() vim.lsp.buf.formatting() end, "Format" },
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
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities
    -- settings = {
    --   Lua = {
    --     diagnostics = {
    --       globals = { 'vim' }
    --     }
    --   }
    -- }
  }

  local opts_dev = {
    library = {
      vimruntime = true, -- runtime path
      types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
      plugins = true, -- installed opt or start plugins in packpath
      -- you can also specify the list of plugins to make available as a workspace library
      -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    runtime_path = false,
    lspconfig = opts
  }

  local luadev_require = require('lua-dev').setup(opts_dev)
  require("lspconfig")["sumneko_lua"].setup(luadev_require)
  require("lspconfig")["rnix"].setup(opts)
  require("lspconfig")["gopls"].setup(opts)
  require("lspconfig")["dockerls"].setup(opts)
  require("lspconfig")["yamlls"].setup(opts)
  -- require("lspconfig")["jedi_language_server"].setup(opts)
  require("lspconfig")["pyright"].setup(opts)
  require("lspconfig")["hls"].setup(opts)
  -- require("lspconfig")["omnisharp"].setup {
  --   cmd = { "OmniSharp" },
  --
  --   on_attach = on_attach,
  --   capabilities = capabilities
  -- }

  local volar_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
    -- settings = {
    --   Lua = {
    --     diagnostics = {
    --       globals = { 'vim' }
    --     }
    --   }
    -- }
  }
  require("lspconfig")["volar"].setup(volar_opts)
end

return { 'hrsh7th/cmp-nvim-lsp', after = { 'which-key.nvim', 'lua-dev.nvim', 'nvim-lspconfig' }, config = config }
