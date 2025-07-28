require "nvchad.autocmds"

-- Open nvim-tree.lua on startup except when passing a file name
-- Hard-disable netrw so it never steals the directory buffer
vim.g.loaded_netrw, vim.g.loaded_netrwPlugin = 1, 1     -- [13]

local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1 -- nvim . / nvim ~/proj
  local no_name = data.file == "" -- plain `nvim`

  if not directory and not no_name then
    return -- launched with a file → leave tree closed
  end

  if directory then
    vim.cmd.cd(data.file) -- use the passed directory as CWD
  end

  require("nvim-tree.api").tree.open() -- opens & focuses the tree window
end

vim.api.nvim_create_autocmd("VimEnter", { callback = open_nvim_tree })
