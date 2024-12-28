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
			-- import mason
			local mason = require("mason")
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

			-- import mason-lspconfig
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				-- list of servers for mason to install
				ensure_installed = {
					"html",
					"cssls", -- css, scss
					"tailwindcss",
					"volar", -- vuejs
					"ts_ls", -- javascript /typoscipt
					"lua_ls", --lua
					"pyright", -- python
					"jdtls", -- java
				},
				-- automatic_installation = true,
			})

			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				ensure_installed = {
					"jq", -- json formater
					"stylua", -- lua formatter
					"isort", -- python formatter
					"black", -- python formatter
					"google-java-format", -- java formatter
					"xmlformatter", -- xml formatter
					"gofumpt", -- go formatter

					"eslint_d",
					"prettier", -- prettier formatter

					-- "luacheck", -- lua linter // you need luarock to make that working
					"eslint_d", -- js/ts linter
					"pylint", -- python linter
					"checkstyle", -- java linter
				},
				-- automatic_installation = true,
			})

			require("plugins.lsp.conf.keymap").setup()

			-- import lspconfig plugin
			local lspconfig = require("lspconfig")
			-- used to enable autocompletion (assign to every lsp server config)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Change the Diagnostic symbols in the sign column (gutter)
			-- (not in youtube nvim video)
			local signs = {
				Error = " ",
				Warn = " ",
				Hint = "󰠠 ",
				Info = " ",
			}

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- :lua print(vim.inspect(vim.lsp.get_active_clients()))
			mason_lspconfig.setup_handlers({
				-- default handler for installed servers
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["lua_ls"] = function()
					require("plugins.lsp.conf.lua_ls").setup(lspconfig, capabilities)
				end,
				["ts_ls"] = function()
					require("plugins.lsp.conf.ts_ls").setup(lspconfig, capabilities)
				end,
				["volar"] = function()
					require("plugins.lsp.conf.volar").setup(lspconfig, capabilities)
				end,
				["cssls"] = function()
					require("plugins.lsp.conf.cssls").setup(lspconfig, capabilities)
				end,
				["tailwindcss"] = function()
					require("plugins.lsp.conf.tailwindcss").setup(lspconfig, capabilities)
				end,
				["pyright"] = function()
					-- I'm setting up pytiight in after/ftplugin/python.lua for now
				end,
				["jdtls"] = function()
					-- do not init jdtls cause it would be initialasied in after/ftplugin/java.lua
				end,
			})
		end,
	},
}
