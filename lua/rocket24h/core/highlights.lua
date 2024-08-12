-- I have a massive nitpick on some highlight groups
-- so I'm setting their values here to change them
-- when their respective plugin is loaded
local api = vim.api
-- If you're planning on using another color scheme,
-- read their docs to see how to acquire their colors in table form
local colors = require("kanagawa.colors").setup({ theme = "dragon" }).palette

-- Call this function to automatically overwrite highlight groups
-- NOTE that this function should be called once a plugin is loaded
local function overwrite_hl(hl_table)
	for k, v in pairs(hl_table) do
		api.nvim_set_hl(0, k, v)
	end
end

local M = {}

M.overwrite_hl = overwrite_hl

M.native = {
	["NormalFloat"] = {
		fg = api.nvim_get_hl(0, { name = "NormalFloat" }).fg,
		bg = api.nvim_get_hl(0, { name = "Normal" }).bg,
	},
	["FloatBorder"] = {
		fg = api.nvim_get_hl(0, { name = "FloatBorder" }).fg,
		bg = api.nvim_get_hl(0, { name = "Normal" }).bg,
	},
}

M.cmp = {
	["CmpItemCursor"] = {
		fg = colors.dragonBlack1,
		bg = colors.dragonGreen2,
	},
	["CmpItemAbbr"] = {
		fg = colors.dragonWhite,
	},
}

M.tree = {
	["NvimTreeWindowPicker"] = {
		fg = "#a4b595",
		bg = colors.dragonBlack1,
	},
	["NvimTreeFolderIcon"] = {
		-- Yellow
		fg = colors.dragonYellow,
	},
	["NvimTreeFolderArrowOpen"] = {
		fg = colors.dragonYellow,
	},
	["NvimTreeFolderArrowClosed"] = {
		fg = colors.dragonYellow,
	},
	["NvimTreeIndentMarker"] = {
		fg = colors.dragonGray,
	},
}

M.telescope = {
	-- This is for the non-bordered setup
	["TelescopeBorder"] = {
		fg = colors.dragonBlack3,
	},
	["TelescopePromptNormal"] = {
		fg = colors.dragonGray,
	},
	["TelescopePromptPrefix"] = {
		fg = colors.dragonYellow,
	},
	["TelescopeTitle"] = {
		fg = colors.dragonBlack1,
	},
	["TelescopePromptTitle"] = {
		bg = colors.dragonBlue2,
	},
	["TelescopePreviewTitle"] = {
		bg = colors.dragonOrange2,
	},
	["TelescopeResultsTitle"] = {
		bg = colors.dragonGreen2,
	},
	["TelescopeSelectionCaret"] = {
		fg = colors.dragonWhite,
	},
}
return M
