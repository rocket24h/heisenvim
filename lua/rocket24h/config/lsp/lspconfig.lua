local lspconfig = require("lspconfig")
local utils = require("rocket24h.core.utils")

-- Setting up some diagnostics icons first
local signs = {
	Error = utils.diagnostics.error,
	Warn = utils.diagnostics.warn,
	Hint = utils.diagnostics.hint,
	Info = utils.diagnostics.info,
}
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Automatically configured servers
local servers = require("rocket24h.core.globals").servers
local on_attach = require("rocket24h.core.keymaps").lsp()
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local config = {
	on_attach = on_attach,
	capabilities = capabilities,
}

for _, server in ipairs(servers) do
	lspconfig[server].setup({ config })
end

-- Custom configuration for certain servers
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	settings = { -- custom settings for lua
		Lua = {
			-- Make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- Make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
