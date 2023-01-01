local function config()
  local opts = {
    window = {
      position = "float"
    },
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added     = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified  = "M", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted   = "D", -- this can only be used in the git_status source
          renamed   = "R", -- this can only be used in the git_status source
          -- Status type
          untracked = "U",
          ignored   = "I",
          unstaged  = "",
          staged    = "",
          conflict  = "",
        }
      },
    }
  }

  require("neo-tree").setup(opts)

  local mappings = {
    e = {
      name = "Explorer",
      o = { "<cmd>Neotree<cr>", "Open explorer" },
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

return { "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "which-key.nvim",
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = config,
}
