-- tabs & indentation
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.tabstop = 2 -- n spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- n spaces for indent width

local project_name = string.gsub(vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h"), "/", "_")
local workspace_path = vim.fn.expand("~/.cache/jdtls/workspace/common-workspace/" .. project_name)
local mason_jdtls_path = "~/.local/share/nvim/mason/packages/jdtls/"
local conf_path = vim.fn.expand(mason_jdtls_path .. "config_mac")
local jar_luncher = vim.fn.glob(mason_jdtls_path .. "plugins/org.eclipse.equinox.launcher_*.jar")
local root_init_files = { ".git", "pom.xml", "mvnw", "gradlew" }
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("spring_boot").init_lsp_commands()

local config = {
	cmd = {
		"java",
		"-Djava.import.generatesMetadataFilesAtProjectRoot=false",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.level=ALL",
		"-Xmx2G",
		"-javaagent:" .. vim.fn.glob(mason_jdtls_path .. "*.jar"),
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		jar_luncher,
		"-configuration",
		conf_path,
		"-data",
		workspace_path,
	},
	capabilities = capabilities,
	root_dir = vim.fs.dirname(vim.fs.find(root_init_files, { upward = true })[1]),
	settings = {
		java = {
			flags = {
				allow_incremental_sync = true,
			},
			maven = {
				downloadSources = true,
			},
			signatureHelp = { enabled = true },
			import = { enabled = true },
			rename = { enabled = true },
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},
			completion = {
				favoriteStaticMembers = {
					"org.assertj.core.api.Assertions.*",
					"org.mockito.Mockito.*",
					"org.mockito.ArgumentMatchers.*",
				},
			},
		},
		init_options = {
			bundles = require("spring_boot").java_extensions(),
		},
	},
}

require("jdtls").start_or_attach(config)
