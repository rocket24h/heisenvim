local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local usercmd = api.nvim_create_user_command

-- IMPORTANT!!!
-- Run this command to install all of the defined language servers
-- as well as linters, formatters,...
usercmd("MasonInstallAll", function()
	local packages = table.concat(require("rocket24h.core.globals").mason_packages, " ")
	vim.cmd("MasonInstall " .. packages)
end, {})

-- Pretty standard highlight-on-yank
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- Trigger linters automatically
local lint_augroup = augroup("lint", { clear = true })

autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		local lint_status, lint = pcall(require, "lint")
		if lint_status then
			lint.try_lint()
		end
	end,
})
