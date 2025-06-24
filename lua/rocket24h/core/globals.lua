local M = {}

-- First and foremost, your colorscheme here
M.colorscheme = "kanagawa-dragon"
-- M.colorscheme = "default"

-- I've decided to make 2 different setups for Telescope UI
-- I'm currently using the default setup, you can switch to the
-- bordered setup by changing this variable to true
M.telescope_bordered = false

-- Use arrows instead of inline markers for nvim-tree
M.use_arrows = false

-- NOTE:
-- Since we're not using 3rd-party plugins to automatically install stuff, we gotta be careful with package names
-- I'm splitting packages to be installed and setup servers separately to prevent errors

-- Define language servers to be set up here
-- See nvim-lspconfig documentations for the supported servers
M.servers = {
	"pyright",
	"clangd",
	"html",
	"cssls",
	"eslint",
	"vimls",
	"lemminx",
}

-- Make sure these entries correspond to those listed in the Mason UI
M.mason_packages = {
	-- LSPs
	"pyright",
	"clangd",
	"html-lsp",
	"css-lsp",
	"eslint-lsp",
	"vim-language-server",
	"lua-language-server",
	"jdtls",
	"lemminx",

	-- Linters & Formatters
	"prettier",
	"stylua",
	"isort",
	"black",
	"eslint_d",
	"mypy",
	"ruff",

	-- Debuggers
	"debugpy",
	"codelldb",
}

return M
