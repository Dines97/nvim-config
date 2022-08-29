local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

local packer_init_config = {
  max_jobs = 10
}

require('packer').init(packer_init_config)

local function onedark_config()
  local opts = {
    style = 'darker',
    transparent = false,
    code_style = {
      comments = 'none',
      keywords = 'italic',
      functions = 'none',
      strings = 'none',
      variables = 'none'
    }
  }

  require("onedark").setup(opts)
  require("onedark").load()
end

local function nvim_treesitter_config()
  local opts = {
    ensure_installed = { "c", "cpp", "lua", "rust", "nix", "dockerfile", "yaml", "python", "go", "haskell", "make", "vue",
      "javascript" },
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

local function nvim_tree_config()
  require('nvim-tree').setup()
end

local function lualine_config()
  local opts = {
    options = {
      globalstatus = true,
      theme = 'onedark',
      section_separators = '',
      component_separators = '',
    },
    sections = {
      lualine_b = { 'branch', 'diff',
        { 'diagnostics', symbols = { error = 'e', warn = 'w', info = 'i', hint = 'h' } } },
      lualine_x = { 'encoding', { 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR', } }, 'filetype' }
    }
  }

  require("lualine").setup(opts)
end

local function bufferline_config()
  require("bufferline").setup()
end

local function gitsigns_config()
  require('gitsigns').setup()
end

local function tmux_config()
  local opts = {
    navigation = {
      enable_default_keybindings = true,
    },
    resize = {
      enable_default_keybindings = false
    }
  }

  require("tmux").setup(opts)
end

local function surround_config()
  local opts = {
    mappings_style = "sandwich"
  }

  require("surround").setup(opts)
end

local function which_key_config()
  local opts = {
    plugins = {
      marks = false, -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
      spelling = { enabled = false, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    }
  }

  require("which-key").setup(opts)

  local mappings = {
    f = {
      name = "File", -- optional group name
      f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = false }, -- additional options for creating the keymap
      n = { "New File" }, -- just a label. don't create any mapping
      e = "Edit File", -- same as above
      ["1"] = "which_key_ignore", -- special label to hide it in the popup
      b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
    },
    g = {
      name = "Git",
      a = { "<cmd>Gwrite<cr>", "Git add" },
      s = { "<cmd>Git<cr>", "Git status" },
      p = { function() require("gitsigns").preb_hunk() end, "Prev hunk" },
      n = { function() require("gitsigns").next_hunk() end, "Next hunk" },
      h = { function() require("gitsigns").preview_hunk() end, "Preview hunk" }
    },
    P = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      -- r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    e = {
      name = "Explorer",
      o = { "<cmd>NvimTreeOpen<cr>", "Open explorer" },
      c = { "<cmd>NvimTreeClose<cr>", "Close explorer" },
      r = { "<cmd>NvimTreeRefresh<cr>", "Refresh explorer" }
    },
    N = {
      name = "Neovim",
      r = { "<cmd>luafile $MYVIMRC<cr>", "Realod config" }
    },
    L = {
      name = "LSP audit",
      i = { "<cmd>LspInfo<cr>", "Info" },
      s = { "<cmd>LspStart<cr>", "Start" },
      r = { "<cmd>LspRestart<cr>", "Restart" },
      p = { "<cmd>LspStop<cr>", "Stop" },
    },
    l = {
      name = "LSP",
      c = { function() vim.diagnostic.open_float() end, "Float" },
      l = { '<cmd>Trouble workspace_diagnostics<cr>', "List" }

    },
    t = {
      name = "Telescope",
      f = { function() require('telescope.builtin').find_files() end, 'Files' }
    }
  }

  local mappings_opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  require("which-key").register(mappings, mappings_opts)
end

local function cmp_nvim_lsp_config()
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

local function nvim_cmp_config()
  local luasnip = require('luasnip')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    },
  }

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

local function nvim_treesitter_context_config()
  require('treesitter-context').setup()
end

-- local function nvim_lsp_installer_config()
--   local opts = {
--     ensure_installed = { 'dockerls', 'yamlls' }
--   }
--
--   require("nvim-lsp-installer").setup(opts)
-- end

-- local function suda_config()
--   -- vim.g.suda_smart_edit = 1
-- end

local function presence_config()
  require("presence"):setup()
end

local function autopairs_config()
  require("nvim-autopairs").setup()
end

local function null_ls_config()
  local null_ls = require("null-ls")

  local opts = {
    sources = {
      null_ls.builtins.formatting.isort,
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.formatting.black,
      -- null_ls.builtins.diagnostics.vale

      null_ls.builtins.formatting.prettier

    }
  }

  require("null-ls").setup(opts)
end

local function indent_config()
  local opts = {
    show_current_context = true,
    show_current_context_start = true
  }

  require("indent_blankline").setup(opts)
end

local function pretty_fold_config()
  require("pretty-fold").setup()
  require("pretty-fold.preview").setup()
end

local function telescope_config()
  require('telescope').setup()
end

local function comment_config()
  require('Comment').setup()
end

local function dap_go_config()
  require('dap-go').setup()
end

local function dap_ui_config()
  local opts = {
    layouts = {
      {
        elements = {
          "scopes",
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 0.20, -- 25% of total lines
        position = "bottom",
      },
    }
  }

  require("dapui").setup(opts)
end

local function luasnip_config()
  local opts = {
    include = { "go" }
  }

  require("luasnip.loaders.from_vscode").load(opts)
end

local function trouble_config()
  require('trouble').setup()
end

local function alpha_config()
  require('alpha').setup(require('alpha.themes.dashboard').config)
end

local function auto_save_config()
  local opts = {
    trigger_events = { "InsertLeave" }
  }

  require('auto-save').setup(opts)
end

local function packer_plugins(use)
  -- Plugin manager
  use { 'wbthomason/packer.nvim' }

  -- Themes START
  use { 'navarasu/onedark.nvim', config = onedark_config }
  -- Themes END

  -- Startup START
  use { 'goolord/alpha-nvim', config = alpha_config }
  -- Startup END

  -- use { 'pocco81/auto-save.nvim', cofifg = auto_save_config }

  -- DAP Start
  use { 'mfussenegger/nvim-dap' }

  use { 'leoluz/nvim-dap-go', config = dap_go_config }

  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" }, config = dap_ui_config }
  -- DAP End

  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim', config = telescope_config }

  use { 'anuvyklack/pretty-fold.nvim', requires = 'anuvyklack/nvim-keymap-amend' }

  use { 'lukas-reineke/indent-blankline.nvim', config = indent_config }

  use { 'andweeb/presence.nvim', config = presence_config }

  use { 'marcelofern/vale.nvim' }

  use { "windwp/nvim-autopairs", config = autopairs_config }

  use { 'towolf/vim-helm' }

  use { 'rcarriga/nvim-notify' }

  -- use { 'lambdalisue/suda.vim', config = suda_config }

  use { 'hrsh7th/cmp-nvim-lsp', after = { 'which-key.nvim', 'lua-dev.nvim', 'nvim-lspconfig' },
    config = cmp_nvim_lsp_config }

  use { 'saadparwaiz1/cmp_luasnip', }

  use { 'L3MON4D3/LuaSnip', config = luasnip_config }

  use { "rafamadriz/friendly-snippets" }

  use { "folke/lua-dev.nvim" }


  -- LSP Start
  -- Ready made LSP configs
  use { 'neovim/nvim-lspconfig' }

  -- LSP helper functions to use with lualine
  use { 'nvim-lua/lsp-status.nvim' }

  -- use { 'williamboman/nvim-lsp-installer', config = nvim_lsp_installer_config }

  use { 'jose-elias-alvarez/null-ls.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = null_ls_config }

  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons', config = trouble_config }

  use { 'hrsh7th/nvim-cmp', after = { 'LuaSnip', 'nvim-autopairs' }, config = nvim_cmp_config }
  -- LSP End

  -- Treesitter
  use(require('plugins.treesitter'))

  use { 'nvim-treesitter/nvim-treesitter-context', after = 'nvim-treesitter', config = nvim_treesitter_context_config }

  use { 'numToStr/Comment.nvim', config = comment_config }

  -- File tree
  use { "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons", }, config = nvim_tree_config }

  -- lualine
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }, config = lualine_config }

  -- bufferline
  use { 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons' }, config = bufferline_config }

  -- Git
  use { 'lewis6991/gitsigns.nvim', config = gitsigns_config }

  use { "tpope/vim-fugitive" }

  -- tmux
  use { "aserowy/tmux.nvim", config = tmux_config }

  use { "ur4ltz/surround.nvim", config = surround_config }

  use { "moll/vim-bbye" }

  -- Space menu
  use { "max397574/which-key.nvim", config = which_key_config }

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
