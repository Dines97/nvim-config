require("plugin_loader")

require("keymaps").load()

vim.g.mapleader = ' '
vim.opt.timeoutlen = 0
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.undofile = true

vim.opt.scrolloff = 5

vim.cmd('syntax on')

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  callback = function() vim.lsp.buf.format({ async = false }) end
})
