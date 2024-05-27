return {
	-- List all of your plugins here!

	-- I will be using RRethy's base16 colorscheme, Tomorrow-night variant to be specific
	-- feel free to add some more to your liking
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require("rocket24h.config.base16")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("rocket24h.config.nvim-tree")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("rocket24h.config.nvim-treesitter")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("rocket24h.config.telescope")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("rocket24h.config.lsp.lspconfig")
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("rocket24h.config.lsp.mason")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				version = "v2.*",
				-- build = { "make install_jsregexp" },
			},
		},
		config = function()
			require("rocket24h.config.nvim-cmp")
		end,
	},
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("rocket24h.config.conform")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("rocket24h.config.nvim-lint")
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		-- Configuration is in ftplugin/java.lua
	},
}
