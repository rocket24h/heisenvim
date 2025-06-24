-- debugpy venv path
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy"
local debugpy_path = mason_path .. "/venv/bin/python"

if vim.fn.has("win32") == 1 then
	debugpy_path = mason_path .. "\\venv\\Scripts\\python.exe"
end

require("dap-python").setup(debugpy_path)

-- Fix treesitter highlighting for Python files
local ts_utils = require("nvim-treesitter.ts_utils")
local parsers = require("nvim-treesitter.parsers")

-- Ensure Python parser is available and force enable highlighting
if parsers.has_parser("python") then
	vim.treesitter.start(0, "python")
	-- Force refresh highlighting
	vim.defer_fn(function()
		if vim.bo.filetype == "python" then
			vim.cmd("TSBufEnable highlight")
		end
	end, 50)
end

-- Alternative: Set up manual syntax highlighting if treesitter fails
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.py",
	callback = function()
		if not vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
			-- Fallback to manual syntax if treesitter isn't working
			vim.cmd("syntax on")
			vim.cmd("set syntax=python")
		end
	end,
})