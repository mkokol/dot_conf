return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"html",
				"lua_ls",
				"pyright",
				"jdtls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"google-java-format", -- java formatter
				"xmlformatter", -- xml formatter
				"gofumpt", -- go formatter

				-- "luacheck", -- lua linter // you need luarock to make that working
				"eslint_d", -- js/ts linter
				"pylint", -- js/ts linter
				"checkstyle", -- java linter
			},
		})
	end,
}
