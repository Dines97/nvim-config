local function config()
  require("nvim-autopairs").setup()
end

return { "windwp/nvim-autopairs", config = config }
