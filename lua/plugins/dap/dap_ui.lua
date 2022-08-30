local function config()
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

return { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" }, config = config }
