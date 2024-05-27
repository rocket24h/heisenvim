-- Minor performance improvement (?) tweak
require("nvim-treesitter.install").prefer_git = true
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
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
