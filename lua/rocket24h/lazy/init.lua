require("rocket24h.lazy.bootstrap")

-- Load lazy.nvim
local plugins = require("rocket24h.lazy.plugins")
local opts = {
	defaults = {
		lazy = false,
	},
	checker = {
		notify = false,
		enabled = true,
	},
	ui = {
		icons = {
			cmd = " ",
			config = "",
			event = " ",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "󰒲 ",
			loaded = " ",
			not_loaded = " ",
			plugin = " ",
			runtime = " ",
			require = "󰢱 ",
			source = " ",
			start = " ",
			task = "✔ ",
			list = {
				" ",
				"➜ ",
				"★ ",
				"‒ ",
			},
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
			},
		},
	},
}

-- Wrapping things up
require("lazy").setup(plugins, opts)
