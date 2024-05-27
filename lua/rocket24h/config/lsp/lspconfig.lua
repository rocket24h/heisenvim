local lspconfig = require("lspconfig")

-- Automatically configured servers
local servers = require("rocket24h.core.globals").servers
local on_attach = require("rocket24h.core.keymaps").lsp()
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local config = {
  on_attach = on_attach,
  capabilities = capabilities,
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({config})
end

-- Custom configuration for certain servers
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
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
