local get_hex = require("cokeline.hlgroups").get_hl_attr
local _, utils = pcall(require, "rocket24h.core.utils")
require("cokeline").setup({
	default_hl = {
		fg = function(buffer)
			return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Keyword", "fg")
		end,
		bg = "NONE",
	},
	sidebar = {
		filetype = { "NvimTree", "neo-tree" },
		components = {
			{
				text = function(buffer)
					return "  " .. utils.ui.file_tree .. "  " .. buffer.filetype
				end,
				fg = function()
					return get_hex("Normal", "fg")
				end,
				bg = function()
					return get_hex("StatusLine", "bg")
				end,
				bold = true,
			},
		},
	},

	components = {
		{
			text = function(buffer)
				return (buffer.index ~= 1) and "|" or ""
			end,
			fg = function()
				return get_hex("StatusLine", "fg")
			end,
		},
		{
			text = function(buffer)
				return " " .. buffer.devicon.icon
			end,
			fg = function(buffer)
				return buffer.devicon.color
			end,
		},
		{
			text = function(buffer)
				return buffer.unique_prefix
			end,
			fg = get_hex("Comment", "fg"),
			italic = true,
		},
		{
			text = function(buffer)
				return buffer.filename .. " "
			end,
			underline = function(buffer)
				return buffer.is_hovered and not buffer.is_focused
			end,
		},
		{
			text = function(buffer)
				if buffer.diagnostics.errors ~= 0 then
					return utils.diagnostics.error
				end
				if buffer.diagnostics.warnings ~= 0 then
					return utils.diagnostics.warn .. " "
				end
				return ""
			end,

			fg = function(buffer)
				if buffer.diagnostics.errors ~= 0 then
					return get_hex("Error", "fg")
				end
				if buffer.diagnostics.warnings ~= 0 then
					return get_hex("DiagnosticWarn", "fg")
				end
			end,
		},
		{
			text = " 󰱝",
			on_click = function(_, _, _, _, buffer)
				buffer:delete()
			end,
		},
		{
			text = "  ",
		},
	},
})
