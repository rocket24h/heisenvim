local cmp = require("cmp")
local luasnip = require("luasnip")
local api = vim.api

-- Creating a new highlight group for nvim-cmp window
-- I have a slight ick with the current color
local cmp_fg = require("base16-colorscheme").colors.base05
local cursor_bg = require("base16-colorscheme").colors.base0B
local cursor_fg = require("base16-colorscheme").colors.base01
api.nvim_set_hl(0, "CmpItemCursor", { bg = cursor_bg, fg = cursor_fg, bold = true })
api.nvim_set_hl(0, "CmpItemAbbr", { fg = cmp_fg })

require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	completion = {
		completeopt = "menu, menuone, preview",
	},

	experimental = {
		ghost_text = true,
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "luasnip" },
	}),

	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),

	ConfirmOption = {
		select = true,
		cmp.ConfirmBehavior.Replace,
	},

	window = {
		completion = cmp.config.window.bordered({
			scrollbar = true,
			winhighlight = "CursorLine:CmpItemCursor",
			side_padding = 1,
			col_offset = 1,
		}),
		documentation = cmp.config.window.bordered({
			scrollbar = true,
			winhighlight = "Normal:Normal",
			size_padding = 1,
			col_offset = 1,
		}),
	},

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. ")"
			return kind
		end,
	},
})
