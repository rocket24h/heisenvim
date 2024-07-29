local dap = require("dap")
local registry = require("mason-registry")

-- C/C++/Rust
local codelldb_path = registry.get_package("codelldb"):get_install_path()

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		-- CHANGE THIS to your debugger executable path!
		command = codelldb_path .. "/extension/adapter/codelldb",
		args = { "--port", "${port}" },

		-- On windows you may have to uncomment this:
		detached = false,
	},
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
