local function config()
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

return { "aserowy/tmux.nvim", config = config }
