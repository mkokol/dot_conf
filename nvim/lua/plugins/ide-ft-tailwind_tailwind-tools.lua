return {
	"luckasRanarison/tailwind-tools.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local tailwind_config = vim.fn.findfile("tailwind.config.js", vim.fn.getcwd() .. ";")

		if tailwind_config ~= "" then
			---@diagnostic disable-next-line: missing-fields
			require("tailwind-tools").setup({
				filetypes = { "html", "css", "vue", "javascriptreact", "typescriptreact" },
				colors = {
					enabled = true,
				},
				document_color = {
					inline_symbol = "󰝤",
				},
				sorting = {
					enabled = true,
					method = "native",
				},
			})

			vim.keymap.set("n", "<leader>ts", ":TailwindSort<CR>", { desc = "[T]ailwind [S]ort classes" })
			vim.keymap.set("n", "<leader>tc", ":TailwindColorToggle<CR>", { desc = "[T]ailwind toggles [C]olor hints" })
		end
	end,
}
