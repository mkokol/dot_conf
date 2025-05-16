return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		-- https://github.com/PauloRPA/neovim_config/blob/958a04376b5eaf95a18e7003d9b3b66f025dff96/config/nvim/assets/lint/java/checkstyle/custom_google_checks.xml
		-- lint.linters.checkstyle.args = {
		-- 	"-c",
		-- 	function()
		-- 		return os.getenv("HOME") .. "/.config/nvim/conf/java-checkstyle.xml"
		-- 	end,
		-- }

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			python = { "pylint" },
			-- java = { "checkstyle" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>la", function()
			lint.try_lint()
		end, { desc = "Trigger [L]inting [A]ll in current file" })
	end,
}
