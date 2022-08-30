local function config()
  local opts = {
    mappings_style = "sandwich"
  }

  require("surround").setup(opts)
end

return { "ur4ltz/surround.nvim", config = config }
