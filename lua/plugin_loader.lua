local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

local packer_init_config = {
  max_jobs = 10,
}

require('packer').init(packer_init_config)

local function packer_plugins(use)
  -- Plugin manager
  use { 'wbthomason/packer.nvim' }

  local function recursive_require_files(folder, path)
    for _, entry in ipairs(vim.fn.readdir(folder)) do
      if entry:sub(1, 1) ~= '_' then
        if vim.fn.isdirectory(folder .. '/' .. entry) ~= 0 then
          recursive_require_files(folder .. '/' .. entry, path .. entry .. '.')
        else

          local ok, table = pcall(require, path .. entry:gsub('%.lua$', ''))
          if not ok then
            print("Error require: " .. path .. entry:gsub('%.lua$', ''))
          end

          use(table)
        end
      end
    end
  end

  recursive_require_files(vim.fn.stdpath('config') .. '/lua/plugins', 'plugins.')

  -- use { '/home/denis/projects/idenator.nvim', config = function()
  --   require('idenator').setup()
  --
  -- end }

  use { 'marcelofern/vale.nvim' }

  use { 'towolf/vim-helm' }

  use { 'rcarriga/nvim-notify' }

  use { 'saadparwaiz1/cmp_luasnip', }

  use { "rafamadriz/friendly-snippets" }

  -- LSP Start
  -- Ready made LSP configs
  use { 'neovim/nvim-lspconfig' }

  -- LSP helper functions to use with lualine
  use { 'nvim-lua/lsp-status.nvim' }

  -- LSP End
  use { "tpope/vim-fugitive" }
  use { "moll/vim-bbye" }


  if packer_bootstrap then
    require('packer').sync()
  end
end

local packer_startup_config = {
  display = {
    -- open_fn = require('packer.util').float,
  }
}

require('packer').startup({ packer_plugins, config = packer_startup_config })
