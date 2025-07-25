local project_name = string.gsub(vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h"), "/", "_")
local workspace_path = vim.fn.expand("~/.cache/jdtls/workspace/common-workspace/" .. project_name)

local mason_jdtls_path = "~/.local/share/nvim/mason/packages/jdtls/"
local conf_path = vim.fn.expand(mason_jdtls_path .. "config_mac_arm")
local jar_luncher = vim.fn.glob(mason_jdtls_path .. "plugins/org.eclipse.equinox.launcher_*.jar")

require("spring_boot").init_lsp_commands()

local config = {
	cmd = {
		"java",
		"-Djava.import.generatesMetadataFilesAtProjectRoot=false",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. vim.fn.glob(mason_jdtls_path .. "*.jar"),
		"-Xmx2G",
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
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	root_dir = vim.fs.dirname(vim.fs.find({ ".git", "pom.xml", "build.gradle" }, { upward = true })[1]),
	settings = {
		java = {
			format = {
				enabled = false,
			},
			configuration = {
				runtimes = {
					{
						name = "JavaSE-21",
						path = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home",
					},
					{
						name = "JavaSE-24",
						path = "/Library/Java/JavaVirtualMachines/temurin-24.jdk/Contents/Home",
					},
				},
			},
			trace = {
				server = "verbose",
			},
			flags = {
				allow_incremental_sync = true,
			},
			maven = {
				downloadSources = true,
			},
			signatureHelp = { enabled = true },
			import = {
				enabled = true,
				gradle = {
					wrapper = {
						enabled = true,
					},
				},
			},
			rename = { enabled = true },
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
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
	},
	init_options = {
		bundles = require("spring_boot").java_extensions(),
	},
}

require("jdtls").start_or_attach(config)
