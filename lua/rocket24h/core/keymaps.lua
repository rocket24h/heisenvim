-- Map your leader key here
vim.g.mapleader = " "

local M = {}
local keymap = vim.keymap
local allow_remap = { noremap = false, silent = true }
local disallow_remap = { noremap = true, silent = true }

function M.default()
	local opts = disallow_remap

	opts.desc = "Switch to right buffer"
	keymap.set("n", "<C-l>", "<C-W>l", opts)

	opts.desc = "Switch to left buffer"
	keymap.set("n", "<C-h>", "<C-W>h", opts)

	opts.desc = "Turn off search highlighting"
	keymap.set("n", "<Esc>", "<cmd>noh<CR>", opts)

	opts.desc = "Control + S to save file"
	keymap.set("n", "<C-s>", "<cmd>w!<CR>", opts)

	-- Vertical & horizontal split, VSCode fashion
	opts.desc = "Vertical split"
	keymap.set("n", "<A-k>", "<cmd>vsplit<CR>", opts)

	opts.desc = "Horizontal split"
	keymap.set("n", "<A-h>", "<cmd>split<CR>", opts)
end

function M.nvim_tree()
	-- Toggle nvim-tree file explorer
	local opts = disallow_remap
	opts.desc = "Toggle NvimTree"
	keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)
end

function M.lsp(client, bufnr)
	local opts = disallow_remap
	opts.buffer = bufnr

	opts.desc = "Show LSP references"
	keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

	opts.desc = "Go to declaration"
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

	opts.desc = "Show LSP definitions"
	keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

	opts.desc = "Show LSP implementations"
	keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

	opts.desc = "Show LSP type definitions"
	keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

	opts.desc = "See available code actions"
	keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

	opts.desc = "Smart rename"
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	opts.desc = "Show buffer diagnostics"
	keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

	opts.desc = "Show line diagnostics"
	keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts)

	opts.desc = "Go to previous diagnostic"
	keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

	opts.desc = "Go to next diagnostic"
	keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

	opts.desc = "Show documentation for what is under cursor"
	keymap.set("n", "K", vim.lsp.buf.hover, opts)

	opts.desc = "Restart LSP"
	keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
end

function M.telescope()
	local opts = disallow_remap

	opts.desc = "Fuzzy find files in cwd"
	keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)

	opts.desc = "Fuzzy find recent files"
	keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", opts)

	opts.desc = "Find string in current working directory"
	keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", opts)

	opts.desc = "Find string under cursor"
	keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", opts)
end

return M
