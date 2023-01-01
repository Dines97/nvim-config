local function config()
  local opts = {
    ensure_installed = { 'dockerls', 'yamlls' }
  }

  require("nvim-lsp-installer").setup(opts)
end

return { 'williamboman/nvim-lsp-installer', config = config, enabled = false }
