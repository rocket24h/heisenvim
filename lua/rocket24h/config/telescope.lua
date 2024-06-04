local ts = require("telescope")
local api = vim.api
local telescope_bordered = require("rocket24h.core.globals").telescope_bordered
local utils = require("rocket24h.core.utils")
local ts_border = utils.ts_border

local bordered_setup = {
	borderchars = {
		prompt = ts_border,
		results = ts_border,
		preview = ts_border,
	},
	border = { prompt = { 1, 1, 1, 1 }, results = { 1, 1, 1, 1 }, preview = { 1, 1, 1, 1 } },
	layout_config = {
		horizontal = {
			prompt_position = "top",
		},
	},
}

local normal_setup = {
	layout_config = {
		horizontal = {
			prompt_position = "top",
		},
	},
}

local main_setup = normal_setup

if telescope_bordered then
	-- Change border highlight groups since base16 colors sometimes blend in the background
	-- Feel free to change this if it troubles you
	local border_color = require("base16-colorscheme").colors.base02
	local fg = require("base16-colorscheme").colors.base03
	local bg = api.nvim_get_hl(0, { name = "TelescopeResultsTitle" }).bg
	local prefix = require("base16-colorscheme").colors.base08
	local results = require("base16-colorscheme").colors.base0D

	api.nvim_set_hl(0, "TelescopeBorder", { fg = border_color })
	api.nvim_set_hl(0, "TelescopePromptBorder", { fg = border_color })
	api.nvim_set_hl(0, "TelescopePromptNormal", { fg = fg })
	api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = prefix })
	api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = bg, bg = results })

	-- If you chose to use the bordered setup
	main_setup = bordered_setup
end

ts.setup({
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
	},
	defaults = vim.tbl_extend("error", main_setup, {
		prompt_prefix = utils.ui.search_a .. "  ",
		selection_caret = utils.ui.indicator .. "  ",

		-- Lazyvim setup
		-- open files in the first window that is an actual file.
		-- use the current window if no other window is available.
		get_selection_window = function()
			local wins = vim.api.nvim_list_wins()
			table.insert(wins, 1, vim.api.nvim_get_current_win())
			for _, win in ipairs(wins) do
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].buftype == "" then
					return win
				end
			end
			return 0
		end,
	}),
})
