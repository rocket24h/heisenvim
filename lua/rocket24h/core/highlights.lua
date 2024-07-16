-- I have a massive nitpick on some highlight groups
-- so I'm setting their values here to change them
-- when their respective plugin is loaded
local api = vim.api
local colors = require("base16-colorscheme").colors

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
	["WinSeparator"] = {
		fg = colors.base02,
		bg = api.nvim_get_hl(0, { name = "Normal" }).bg,
	},
	["StatusLine"] = {
		fg = api.nvim_get_hl(0, { name = "StatusLine" }).fg,
		bg = api.nvim_get_hl(0, { name = "CursorLine" }).bg,
	},
}

M.cmp = {
	["CmpItemCursor"] = {
		fg = colors.base01,
		bg = "#a4b595",
	},
	["CmpItemAbbr"] = {
		fg = colors.base05,
	},
}

M.tree = {
	["NvimTreeWindowPicker"] = {
		fg = "#a4b595",
		bg = colors.base01,
	},
	["NvimTreeFolderIcon"] = {
		-- Yellow
		fg = colors.base0A,
	},
	["NvimTreeFolderArrowOpen"] = {
		fg = colors.base0A,
	},
	["NvimTreeFolderArrowClosed"] = {
		fg = colors.base0A,
	},
	["NvimTreeIndentMarker"] = {
		fg = colors.base03,
	},
}

M.lsp = {
	["LspReferenceRead"] = {
		bg = colors.base02,
	},
	["LspReferenceWrite"] = {
		bg = colors.base02,
	},
	["LspReferenceText"] = {
		bg = colors.base02,
	},
}

M.telescope = {
	-- This is for the bordered setup
	["TelescopeBorder"] = {
		fg = colors.base02,
	},
	["TelescopePromptBorder"] = {
		fg = colors.base02,
	},
	["TelescopePromptNormal"] = {
		fg = colors.base03,
	},
	["TelescopePromptPrefix"] = {
		fg = colors.base08,
	},
	["TelescopeResultsTitle"] = {
		fg = api.nvim_get_hl(0, { name = "TelescopeResultsTitle" }).bg,
		bg = colors.base0D,
	},
}
return M
