-- Minor performance improvement (?) tweak
require("nvim-treesitter.install").prefer_git = true
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		-- Disable vim's regex highlighting
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	ensure_installed = {
		"vim",
		"vimdoc",
		"markdown",
		"lua",
		"html",
		"css",
		"javascript",
		"json",
		"c",
		"cpp",
		"python",
		"dockerfile",
		"java",
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
})

-- Force install Python parser if not available
local parsers = require("nvim-treesitter.parsers")
if not parsers.has_parser("python") then
	vim.cmd("TSInstall python")
end

