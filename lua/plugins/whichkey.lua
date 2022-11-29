local function config()
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

return { "folke/which-key.nvim", config = config }
