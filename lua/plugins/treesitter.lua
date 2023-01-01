local function config()
  local opts = {
    ensure_installed = "all",
    -- ensure_installed = { "c", "cpp", "lua", "rust", "nix", "dockerfile", "yaml", "python", "go", "haskell", "make",
    --   "html", "css", "javascript", "typescript", "vue" },
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
    },
    indent = {
      enable = true
    }
  }

  -- vim.opt.foldmethod = 'expr'
  -- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

  require("nvim-treesitter.configs").setup(opts)
end

return { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = config }
