local _, utils = pcall(require, "heirline.utils")
local get_hl = utils.get_highlight
local M = {}

local colors = {
	bg = "#1d1f21",
	fg = "#c5c8c6",
	bright_bg = "#282a2e",
	bright_fg = "#e0e0e0",
	red = "#cc6666",
	green = "#b5bd68",
	blue = "#81a2be",
	gray = "#969896",
	orange = "#de935f",
	purple = "#b294bb",
	cyan = "#8abeb7",
	yellow = "#f0c674",
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
