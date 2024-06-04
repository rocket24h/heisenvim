local opt = vim.opt
local api = vim.api
-- Credits to NvChad, add binaries installed by Mason to PATH
local is_windows = vim.fn.has("win32") ~= 0
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- Indent & tab configuration
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Colorscheme related options
vim.cmd.colorscheme(require("rocket24h.core.globals").colorscheme)
opt.termguicolors = true
opt.background = "dark"
local sep_bg = require("base16-colorscheme").colors.base00
local sep_fg = require("base16-colorscheme").colors.base02
local comment = "#444740"
api.nvim_set_hl(0, "WinSeparator", { fg = sep_fg, bg = sep_bg })
api.nvim_set_hl(0, "TSComment", { fg = comment, italic = true })
api.nvim_set_hl(0, "Comment", { fg = comment, italic = true })

-----------------
-- QoL config
-----------------

-- Show line number
opt.number = true
opt.relativenumber = true

-- Disable vim modes
opt.showmode = false

-- Extend clipboard to OS
opt.clipboard = "unnamedplus"

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

-- Decrease update time
opt.updatetime = 250
