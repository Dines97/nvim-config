local function config()

  local dap = require("dap")

  local mappings = {
    d = {
      name = "Debug",
      b = { function() dap.toggle_breakpoint() end, "Toggle breakpoint" },
      l = { function() dap.continue() end, "Launch" },
      n = { function() dap.step_over() end, "Step over" },
      i = { function() dap.step_into() end, "Step into" },
      o = { function() dap.step_out() end, "Step out" },
      r = { function() dap.repl.open() end, "REPL" },
      p = { function() dap.step_back() end, "Step back" }
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

return { 'mfussenegger/nvim-dap', config = config }
