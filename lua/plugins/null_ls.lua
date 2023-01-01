local function config()
  local null_ls = require("null-ls")

  local opts = {
    sources = {
      null_ls.builtins.formatting.isort,
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.formatting.black,
      -- null_ls.builtins.diagnostics.vale

      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.alejandra

    }
  }

  null_ls.setup(opts)
end

return { 'jose-elias-alvarez/null-ls.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = config }
