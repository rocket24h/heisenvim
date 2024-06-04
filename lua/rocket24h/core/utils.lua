local M = {}

M.ts_border = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

M.git = {
	unstaged = "",
	staged = "󰄭",
	unmerged = "",
	renamed = "󰑕 ",
	untracked = "",
	deleted = "",
	added = "",
	modified = "",
	ignored = "",
}

M.diagnostics = {
	error = " ",
	warn = "",
	hint = "󰠠 ",
	info = " ",
}

M.ui = {
	arch = "󰣇",
	arrow_left = "󰁍",
	arrow_right = "󰁔",
	arrow_up = "󰁝",
	arrow_down = "󰁅",
	bookmark = "󰃀",
	chess = "",
	chevron_left = "",
	chevron_right = "",
	chevron_up = "",
	chevron_down = "",
	circle_chevron_left = "",
	circle_chevron_right = "",
	circle_chevron_up = "",
	circle_chevron_down = "",
	file_tree = "",
	gear = "",
	github = "",
	indicator = "",
	lock = "",
	opensuse = "",
	search_a = "",
	search_b = "󱡴",
	terminal = "",
}

M.chars = {
	block = "█",
	lower_right_angled_triangle = "",
	lower_left_angled_triangle = "",
	upper_left_angled_triangle = "",
	upper_right_angled_triangle = "",
	left_equi_triangle = "",
	right_equi_triangle = "",
	left_semicircle = "",
	right_semicircle = "",
}

return M
