local function config()
  local dapui = require("dapui")

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

  dapui.setup(opts)

  local mappigns = {
    d = {
      name = "Debug",
      u = { function() dapui.toggle() end, "Toggle ui" }
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

  require("which-key").register(mappigns, mappings_opts)
end

return { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" }, config = config }
