-- debugpy venv path
local registry = require("mason-registry")
local debugpy_path = registry.get_package("debugpy"):get_install_path() .. "/venv/bin/python"

if vim.fn.has("win32") then
	debugpy_path = registry.get_package("debugpy"):get_install_path() .. "\\venv\\Scripts\\python"
end

require("dap-python").setup(debugpy_path)
