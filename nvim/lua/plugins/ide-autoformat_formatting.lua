return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				djlint = {
					command = "djlint",
					args = { "--reformat", "--profile=twig" }, -- Enable Twig profile
					stdin = true,
				},
			},
			formatters_by_ft = {
				json = { "fixjson", "prettier" },
				yaml = { "yamlfix" },
				xml = { "xmlformat" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "htmlbeautifier" },
				lua = { "stylua" },
				sh = { "shellcheck" },
				go = { "gofmt" },
				python = { "isort", "black" },
				java = { "google-java-format" },
				php = { "php-cs-fixer" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				vue = { "prettier" },
				twig = { "djlint" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>fa", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 300,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
