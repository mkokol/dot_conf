return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
			{ "mfussenegger/nvim-jdtls" },
			{ "JavaHello/spring-boot.nvim" },
		},
		build = ":MasonUpdate",
		config = function()
			local mason = require("mason")
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			-- import lspconfig plugin
			local lspconfig = require("lspconfig")
			-- used to enable autocompletion (assign to every lsp server config)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- import mason-lspconfig
			local mason_lspconfig = require("mason-lspconfig")
			---@diagnostic disable-next-line: missing-fields
			mason_lspconfig.setup({
				-- list of lsp servers for mason to install
				ensure_installed = {
					"lua_ls", --lua
					"html",
					"cssls", -- css, scss
					"ts_ls", -- javascript /typoscipt
					"volar", -- vuejs
					"pyright", -- python
					"jdtls", -- java
					"terraformls", -- terraform
				},
				-- automatic_installation = true,
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["lua_ls"] = function()
						require("plugins.lsp.conf.lua_ls").setup(lspconfig, capabilities)
					end,
					["cssls"] = function()
						require("plugins.lsp.conf.cssls").setup(lspconfig, capabilities)
					end,
					["ts_ls"] = function()
						require("plugins.lsp.conf.ts_ls").setup(lspconfig, capabilities)
					end,
					["volar"] = function()
						require("plugins.lsp.conf.volar").setup(lspconfig, capabilities)
					end,
					["intelephense"] = function()
						require("plugins.lsp.conf.intelephense").setup(lspconfig, capabilities)
					end,
					["pyright"] = function()
						-- I'm setting up pytiight in after/ftplugin/python.lua for now
					end,
					["jdtls"] = function()
						-- do not init jdtls cause it would be initialasied in after/ftplugin/java.lua
					end,
				},
			})

			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				ensure_installed = {
					"jq", -- json formater
					"xmlformatter", -- xml formatter
					"prettier", -- prettier formatter
					"stylua", -- lua formatter
					"isort", -- python formatter
					"black", -- python formatter
					"pylint", -- python linter
					"google-java-format", -- java formatter
					"checkstyle", -- java linter
					"gofumpt", -- go formatter
					"eslint_d", -- js/ts linter
				},
			})

			require("plugins.lsp.conf.keymap").setup()
		end,
	},
}
