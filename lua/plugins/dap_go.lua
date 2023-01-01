local function config()
  require('dap-go').setup()
end

return { 'leoluz/nvim-dap-go', config = config }
