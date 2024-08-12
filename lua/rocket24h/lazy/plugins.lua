return {
	-- List all of your plugins here!

	-- NOTE:
	-- I will be using rebelot's Kanagawa colorscheme plugin, dragon variant to be specific
	-- Feel free to add some more to your liking
	-- (Switched from base16 due to some poor syntax highlighting and I don't feel like rewriting them all)
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		theme = "wave",
		background = {
			dark = "dragon",
			light = "lotus",
		},
	},
	-- Sweet light theme in case I need to toggle light mode
	{
		"yorickpeterse/vim-paper",
		lazy = true,
	},

	-- Bare necessities, can't live without them
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
		event = { "VimEnter" },
		config = function()
			require("rocket24h.config.nvim-treesitter")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		event = { "UIEnter" },
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
		"mfussenegger/nvim-dap",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("rocket24h.config.lsp.dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("rocket24h.config.lsp.dap-ui")
		end,
	},

	-- New UI Component plugins
	{
		"willothy/nvim-cokeline",
		lazy = true,
		event = { "InsertEnter" },
		config = function()
			require("rocket24h.config.cokeline")
		end,
	},
	{
		"rebelot/heirline.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
		},
		lazy = true,
		event = "UIEnter",
		config = function()
			require("rocket24h.config.heirline")
		end,
	},
	{
		"j-hui/fidget.nvim",
		lazy = true,
		event = { "LspAttach" },
		config = function()
			require("rocket24h.config.fidget")
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- QoL plugins for Neovim
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("rocket24h.config.nvim-conform")
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
		lazy = true,
	},
	{
		"mfussenegger/nvim-dap-python",
		lazy = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("rocket24h.config.gitsigns")
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("rocket24h.config.indent")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = true,
		event = { "UIEnter" },
		config = function()
			require("rocket24h.config.toggleterm")
		end,
	},
	{
		"echasnovski/mini.ai",
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("rocket24h.config.ai")
		end,
	},
	{
		-- Using echasnovski's mini.icons instead of nvim-web-devicons,
		-- remove the config to disable it
		"echasnovski/mini.icons",
		opts = {},
		lazy = true,
		specs = {
			{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"echasnovski/mini.animate",
		version = "*",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.animate").setup()
		end,
	},
	{
		"echasnovski/mini.starter",
		version = "*",
		config = function()
			require("rocket24h.config.starter")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("rocket24h.config.telescope-ui-select")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			require("rocket24h.config/which-key")
		end,
	},
}
