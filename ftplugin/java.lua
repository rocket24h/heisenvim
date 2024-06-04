local system = "linux"
if vim.fn.has("win32") then
	system = "win"
end

local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()
local lombok_path = jdtls_path .. "/lombok.jar"
local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/workspace/" .. project_name
local root_signs = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

require("jdtls").start_or_attach({
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. lombok_path,
		"-jar",
		vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		vim.fn.glob(jdtls_path .. "/config_" .. system),
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root(root_signs),
	on_attach = require("rocket24h.core.keymaps").lsp(),
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	autostart = true,
})
