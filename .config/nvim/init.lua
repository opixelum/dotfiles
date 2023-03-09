local opt = vim.opt

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Sync with system clipboard
opt.clipboard = "unnamedplus"

-- Highlight current line
opt.cursorline = true

-- Use spaces instead of tabs
opt.expandtab = true

-- Display line numbers
opt.number = true

-- Use 4 spaces for tabs using spaces
opt.shiftwidth = 4

-- Insert indents automatically
opt.smartindent = true

-- Use 4 spaces for softtabstop
opt.softtabstop = 4

-- Use 4 spaces for tabs
opt.tabstop = 4

-- Set termguicolors to enable highlight groups
opt.termguicolors = true

-- Import plugins
require("plugins")
