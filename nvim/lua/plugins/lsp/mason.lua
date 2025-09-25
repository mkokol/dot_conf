return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
			-- java specific
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

			local required_lsp_servers = {
				"lua_ls", -- lua
				"html", -- html
				"cssls", -- css, scss
				"ts_ls", -- javascript /typoscipt
				"ruff", -- python

				-- basedpyright alternative for pyright
				"jdtls", -- java
				"terraform", -- terraform
			}

			-- import mason-lspconfig
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = required_lsp_servers,
				automatic_enable = false,
			})

			-- used to enable autocompletion (assign to every lsp server config)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for _, lsp_server_name in ipairs(required_lsp_servers) do
				local ok, lsp_config = pcall(require, "plugins.lsp.conf." .. lsp_server_name)

				if ok and lsp_config and type(lsp_config.config) == "function" then
					lsp_config.config(capabilities)
				else
					vim.lsp.config(lsp_server_name, {
						capabilities = capabilities,
					})
				end

				vim.lsp.enable(lsp_server_name)
			end

			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				ensure_installed = {
					"jq", -- json formater
					"xmlformatter", -- xml formatter
					"prettier", -- prettier formatter
					"stylua", -- lua formatter
					"ruff", -- python formatter and linter
					"google-java-format", -- java formatter
					"checkstyle", -- java linter
					"gofumpt", -- go formatter
					"eslint_d", -- js/ts linter
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(_)
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ desc = "See available [C]ode [A]ctions" }
					)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })
					vim.keymap.set("n", "D", vim.lsp.buf.hover, { desc = "Show [D]ocumentation for code under cursor" })
					vim.keymap.set("n", "gd", vim.lsp.buf.declaration, { desc = "[G]o to [D]eclaration" })
					vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show Diagnostics for Line" })
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, { desc = "Go to next diagnostic" })
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, { desc = "Go to previous diagnostic" })
					vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
				end,
			})

			vim.keymap.set("n", "<leader>mo", "<cmd>Mason<cr>", { desc = "[M]ason window [O]pen" })
		end,
	},
}
