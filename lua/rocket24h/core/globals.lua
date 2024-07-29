local M = {}

-- First and foremost, your colorscheme here
M.colorscheme = "kanagawa-dragon"

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
	"basedpyright",
	"clangd",
	"html",
	"cssls",
	"eslint",
	"vimls",
}

-- Make sure these entries correspond to those listed in the Mason UI
M.mason_packages = {
	-- LSPs
	"basedpyright",
	"clangd",
	"html-lsp",
	"css-lsp",
	"eslint-lsp",
	"vim-language-server",
	"lua-language-server",
	"jdtls",

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
