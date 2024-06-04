local _, utils = pcall(require, "heirline.utils")
local get_hl = utils.get_highlight
local M = {}

local colors = {
	bg = "#000000",
	fg = "#c1c1c1",
	bright_bg = "#222222",
	bright_fg = "#cdd9c5",
	red = "#d94155",
	green = "#99bbaa",
	blue = "#b7dbe5",
	gray = "#999999",
	orange = "#de935f",
	purple = "#b294bb",
	cyan = "#5f8787",
	yellow = "#f7dc97",
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
