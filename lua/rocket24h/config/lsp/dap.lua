local dap = require("dap")

-- Function to safely get mason package install path
local function get_mason_package_path(package_name)
	local ok, registry = pcall(require, "mason-registry")
	if not ok then
		return nil
	end
	
	if not registry.is_installed(package_name) then
		return nil
	end
	
	local package = registry.get_package(package_name)
	-- Use the new API method
	local success, install_path = pcall(function()
		return package:get_install_path()
	end)
	
	if success then
		return install_path
	else
		-- Fallback to manual path construction for older Mason versions
		local mason_path = vim.fn.stdpath("data") .. "/mason"
		return mason_path .. "/packages/" .. package_name
	end
end

-- C/C++/Rust configuration
local function setup_codelldb()
	local codelldb_path = get_mason_package_path("codelldb")

	-- Only setup codelldb if it's available
	if codelldb_path then
		-- Determine the correct executable path based on OS
		local executable_path
		if vim.fn.has("win32") == 1 then
			executable_path = codelldb_path .. "/extension/adapter/codelldb.exe"
		else
			executable_path = codelldb_path .. "/extension/adapter/codelldb"
		end

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = executable_path,
				args = { "--port", "${port}" },
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
		
		return true
	else
		return false
	end
end

-- Setup DAP configurations
local success = setup_codelldb()
if not success then
	-- Only show warning if codelldb is expected but not found
	vim.schedule(function()
		vim.notify(
			"codelldb debugger not found. Install it via Mason: :MasonInstall codelldb", 
			vim.log.levels.WARN,
			{ title = "DAP Configuration" }
		)
	end)
end
