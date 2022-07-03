local M = {}

local keymaps = {
  n = {
    -- Better window movement
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    -- Resize with arrows
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",

    -- Tab switch buffer
    ["<S-l>"] = ":BufferLineCycleNext<CR>",
    ["<S-h>"] = ":BufferLineCyclePrev<CR>",

    -- Move current line / block with Alt-j/k a la vscode.
    ["<A-j>"] = ":m .+1<CR>==",
    ["<A-k>"] = ":m .-2<CR>==",

    -- QuickFix
    ["]q"] = ":cnext<CR>",
    ["[q"] = ":cprev<CR>",
    ["<C-q>"] = ":call QuickFixToggle()<CR>",
  }
}

local default_opts = { noremap = true, silent = true }

function M.load_map(mode, lhs, rhs)
  local opts = default_opts
  if type(rhs) == "table" then
    opts = rhs[2]
    rhs = rhs[1]
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)

end

function M.load_mode(mode, map)
  for lhs, rhs in pairs(map) do
    M.load_map(mode, lhs, rhs)
  end
end

function M.load()
  for mode, map in pairs(keymaps) do
    M.load_mode(mode, map)
  end
end

return M
