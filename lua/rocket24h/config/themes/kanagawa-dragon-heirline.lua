local _, utils = pcall(require, "heirline.utils")
local get_hl = utils.get_highlight
local M = {}

local palette = require("kanagawa.colors").setup().palette

local colors = {
	bg = palette.dragonBlack1,
	fg = palette.dragonWhite,
	bright_bg = palette.dragonBlack4,
	bright_fg = palette.fujiWhite,
	red = palette.dragonRed,
	green = palette.dragonGreen,
	blue = palette.dragonBlue,
	gray = palette.dragonGray,
	orange = palette.dragonOrange,
	purple = palette.dragonViolet,
	cyan = palette.dragonTeal,
	yellow = palette.dragonYellow,

	diag_warn = get_hl("DiagnosticWarn").fg,
	diag_error = get_hl("DiagnosticError").fg,
	diag_hint = get_hl("DiagnosticHint").fg,
	diag_info = get_hl("DiagnosticInfo").fg,
	git_del = get_hl("GitSignsDelete").fg,
	git_add = get_hl("GitSignsAdd").fg,
	git_change = get_hl("GitSignsChange").fg,
}

M.colors = colors

return M
