local function config()
  local opts = {
    trigger_events = { 'InsertLeave' }
  }

  require('auto-save').setup(opts)
end

return { 'pocco81/auto-save.nvim', config = config, enabled = false }
