return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				json = { "fixjson", "prettier" },
				yaml = { "yamlfix" },
				xml = { "xmlformat" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "htmlbeautifier" },
				vue = { "prettier" },
				lua = { "stylua" },
				sh = { "shellcheck" },
				go = { "gofmt" },
				python = { "isort", "black" },
				java = { "google-java-format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
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
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
