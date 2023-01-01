local function config()
  local opts = {
    mappings_style = "sandwich"
  }

  require("nvim-surround").setup(opts)
end

return { "kylechui/nvim-surround", config = config }
