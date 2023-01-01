local function config()
  local opts = {
    keymaps = {
      -- Better window movement
      -- ["<C-h>"] = "<C-w>h",
      -- ["<C-j>"] = "<C-w>j",
      -- ["<C-k>"] = "<C-w>k",
      -- ["<C-l>"] = "<C-w>l",
      --
      -- Resize with arrows
      { '<C-Up>', function() require('tmux').resize_top() end },
      { '<C-Down>', function() require('tmux').resize_bottom() end },
      { '<C-Left>', function() require('tmux').resize_left() end },
      { '<C-Right>', function() require('tmux').resize_right() end },

      -- Tab switch buffer
      { '<S-l>', ':BufferLineCycleNext<CR>' },
      { '<S-h>', ':BufferLineCyclePrev<CR>' },

      -- Move current line / block with Alt-j/k a la vscode.
      { '<A-j>', ':m .+1<CR>==' },
      { '<A-k>', ':m .-2<CR>==' },

      -- QuickFix
      { ']q', ':cnext<CR>' },
      { '[q', ':cprev<CR>' },
      { '<C-q>', ':call QuickFixToggle()<CR>' },
    },
    autocmds = {
      { 'BufWritePre', function () vim.lsp.buf.format({async = false}) end, description = 'Format on save' },
    },
  }

  require('legendary').setup(opts)
end

return { 'mrjones2014/legendary.nvim', config = config }
