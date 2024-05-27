local opt = vim.opt

-- Set your colorscheme here
vim.cmd.colorscheme(require("rocket24h.core.globals").colorscheme)

-- Credits to NvChad, add binaries installed by Mason to PATH
local is_windows = vim.fn.has("win32") ~= 0
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- Indent & tab configuration
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Colorscheme related, purely personal
opt.termguicolors = true
opt.background = "dark"

-----------------
-- QoL config
-----------------

-- Show line number
opt.number = true
opt.relativenumber = true

-- Disable vim modes
opt.showmode = false

-- Extend clipboard to OS
opt.clipboard = 'unnamedplus'

-- File manipulations
opt.undofile = true
opt.hlsearch = true
opt.cursorline = true
opt.swapfile = false
opt.autochdir = true

-- Splitting buffers
opt.splitright = true
opt.splitbelow = true

-- Statusline
opt.laststatus = 3
opt.linespace = 2
opt.fillchars = { eob = " " }
