local _, heirline = pcall(require, "heirline")
local _, conditions = pcall(require, "heirline.conditions")
local _, heirline_utils = pcall(require, "heirline.utils")

-- Add more themes in the theme folder
-- Name them [colorscheme]-heirline.lua, and the command auto detects the theme
local colorscheme = require("rocket24h.core.globals").colorscheme
local _, theme = pcall(require, "rocket24h.config.themes." .. colorscheme .. "-heirline")
local _, devicons = pcall(require, "nvim-web-devicons")
local _, utils = pcall(require, "rocket24h.core.utils")
-- In case file does not exist
if not theme then
	theme = require("rocket24h.config.themes.default-heirline")
end
local colors = theme.colors

-- ========================
-- GETTING THE PARTS READY
-- ========================
local Align = { provider = "%=" }
local Space = { provider = " " }

-- Define modes and their displayed names here
local VimModes = {
	init = function(self)
		self.mode = vim.fn.mode(1)
	end,
	static = {
		-- Defining mode names
		mode_names = {
			n = "NORMAL",
			no = "op?",
			nov = "op?",
			noV = "op?",
			["no\22"] = "op?",
			niI = "NORMAL",
			niR = "NORMAL",
			niV = "NORMAL",
			nt = "NORMAL",
			v = "VISUAL",
			vs = "VISUAL",
			V = "VISUAL LINE",
			Vs = "VISUAL LINE",
			["\22"] = "VISUAL BLOCK",
			["\22s"] = "^VISUAL BLOCK",
			s = "SELECT",
			S = "SELECT",
			["\19"] = "SELECT BLOCK",
			i = "INSERT",
			ic = "INSERT",
			ix = "INSERT",
			R = "REPLACE",
			Rc = "REPLACE",
			Rx = "REPLACE",
			Rv = "V_REPLACE",
			Rvc = "V_REPLACE",
			Rvx = "V_REPLACE",
			c = "COMMAND",
			cv = "COMMAND",
			r = "ENTER",
			rm = "MORE",
			["r?"] = "CONFIRM",
			["!"] = "SHELL",
			t = "TERMINAL",
			["null"] = "NONE",
		},
	},

	-- Assign provider and highlights
	provider = function(self)
		return "  %2(" .. self.mode_names[vim.fn.mode(1)] .. "%)"
	end,

	hl = function(self)
		local color = self:get_mode_color()
		return { bg = color, fg = colors.bg, bold = true }
	end,
	-- I don't get this part
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}
-- FileNameBlock object, will be used later
local FileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

-- Self-explanatory
local FileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon .. " "
	end,
	hl = function(self)
		return { fg = colors.gray }
	end,
}

local FileName = {
	provider = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return "[No Name]"
		end

		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return filename
	end,
	hl = {
		fg = colors.gray,
	},
}

local FileFlags = {
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = " " .. utils.ui.lock,
		hl = { fg = colors.orange },
	},
}

-- Displays a certain color if the file is modified but not saved
local FileNameModifier = {
	hl = function()
		if vim.bo.modified then
			return { fg = colors.fg, bold = true, force = true }
		end
	end,
}

local FileType = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = { fg = colors.purple, bold = true },
}

-- Fun little scrollbar
local ScrollBar = {
	static = {
		sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
	},
	provider = function(self)
		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)
		local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
		return string.rep(self.sbar[i], 2)
	end,
	hl = { fg = colors.green, bg = colors.bg },
}

-- Ruler display
local Ruler = {
	provider = "%7(%l/%3L%)|%2c %P",
	hl = function(self)
		local color = self:get_mode_color()
		return { fg = colors.bg, bg = color }
	end,
}

-- LSP Information
local LSPInfo = {
	condition = conditions.lsp_attached,
	update = {
		"LspAttach",
		"LspDetach",
		"BufEnter",
		"FileType",
		"VimResized",
		callback = function()
			vim.schedule(vim.cmd.redrawstatus)
		end,
	},
	provider = function()
		local names = {}
		for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return utils.ui.gear .. "  " .. table.concat(names, " ")
	end,
	hl = {
		fg = colors.green,
		bold = true,
	},
}

-- Diagnostics
local Diagnostics = {
	condition = conditions.has_diagnostics,
	static = {
		error_icon = utils.diagnostics.error,
		warn_icon = utils.diagnostics.warn .. " ",
		info_icon = utils.diagnostics.info,
		hint_icon = utils.diagnostics.hint,
	},
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	update = { "DiagnosticChanged", "BufEnter" },
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = colors.diag_error },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = colors.diag_warn },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = colors.diag_info },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = { fg = colors.diag_hint },
	},
}

local Git = {
	condition = conditions.is_git_repo,
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	hl = { fg = colors.blue, bg = colors.bright_bg },

	{ -- git branch name
		provider = function(self)
			return utils.ui.gitbranch .. " " .. self.status_dict.head .. " "
		end,
		hl = { bold = true, fg = colors.gray },
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and (" " .. utils.git.added .. " " .. count)
		end,
		hl = { fg = colors.git_add },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and (" " .. utils.git.deleted .. " " .. count)
		end,
		hl = { fg = colors.git_del },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and (" " .. utils.git.modified .. " " .. count)
		end,
		hl = { fg = colors.git_change },
	},
}

local TerminalName = {
	provider = function()
		local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
		return "  " .. utils.ui.terminal .. "  " .. tname
	end,
	hl = { fg = colors.cyan, bold = true },
}

local HelpFileName = {
	condition = function()
		return vim.bo.filetype == "help"
	end,
	provider = function()
		local filename = vim.api.nvim_buf_get_name(0)
		return vim.fn.fnamemodify(filename, ":t")
	end,
	hl = { fg = colors.blue },
}

-- ====================
-- ASSEMBLY LINES HERE
-- ====================

VimModes = heirline_utils.surround(
	{ utils.chars.left_semicircle, utils.chars.block .. utils.chars.lower_right_angled_triangle },
	function(self)
		return self:get_mode_color()
	end,
	{ VimModes }
)

Ruler = heirline_utils.surround(
	{ utils.chars.upper_right_angled_triangle, utils.chars.right_semicircle },
	function(self)
		return self:get_mode_color()
	end,
	{ Ruler, Space }
)

FileNameBlock = heirline_utils.insert(
	FileNameBlock,
	FileIcon,
	heirline_utils.insert(FileNameModifier, FileName),
	FileFlags,
	{ provider = "%<" }
)

local left_segment = {
	heirline_utils.surround(
		{ "", utils.chars.lower_right_angled_triangle },
		colors.bg,
		{ VimModes, Space, FileNameBlock, Space }
	),
	Space,
	heirline_utils.surround({ " ", " " }, colors.bright_bg, { Git }),
}

local right_segment = {
	heirline_utils.surround({ " ", " " }, colors.bright_bg, { Diagnostics }),
	Space,
	heirline_utils.surround(
		{ utils.chars.upper_right_angled_triangle, "" },
		colors.bg,
		{ Space, LSPInfo, Space, Ruler }
	),
	heirline_utils.surround({ "", "" }, colors.bg, { Space }),
	ScrollBar,
}

local DefaultStatusLine = {
	heirline_utils.surround({ "", utils.chars.right_semicircle }, colors.bright_bg, left_segment),
	Align,
	heirline_utils.surround({ utils.chars.left_semicircle }, colors.bright_bg, right_segment),
}

local TerminalStatusline = {
	condition = function()
		return conditions.buffer_matches({ buftype = { "terminal" } })
	end,

	hl = { fg = colors.terminal },

	-- Quickly add a condition to the VimModes to only show it when buffer is active!
	{ condition = conditions.is_active, VimModes, Space },
	TerminalName,
}

local AlphaStatusLine = {
	condition = function()
		return conditions.buffer_matches({
			filetype = { "alpha" },
		})
	end,
}

local SpecialStatusline = {
	condition = function()
		return conditions.buffer_matches({
			buftype = { "nofile", "prompt", "help", "quickfix" },
			filetype = { "^git.*", "fugitive" },
		})
	end,
	hl = { fg = colors.blue },
	Align,
	FileType,
	Space,
	HelpFileName,
	Align,
}

local StatusLines = {
	static = {
		mode_colors = {
			n = colors.blue,
			i = colors.green,
			v = colors.yellow,
			V = colors.yellow,
			["\22"] = colors.yellow,
			c = colors.orange,
			s = colors.purple,
			S = colors.purple,
			["\19"] = colors.purple,
			R = colors.red,
			r = colors.red,
			["!"] = colors.cyan,
			["t"] = colors.cyan,
		},
		get_mode_color = function(self)
			local mode = conditions.is_active() and vim.fn.mode() or "n"
			return self.mode_colors[mode]
		end,
	},
	hl = function()
		if conditions.is_active() then
			return "StatusLine"
		else
			return "debugPC"
		end
	end,
	fallthrough = false,
	-- Apparently order matters, don't alter this
	AlphaStatusLine,
	SpecialStatusline,
	TerminalStatusline,
	DefaultStatusLine,
}

heirline.setup({ statusline = StatusLines })
