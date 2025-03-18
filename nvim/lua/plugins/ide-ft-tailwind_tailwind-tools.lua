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

			vim.api.nvim_set_keymap("n", "<leader>ts", ":TailwindSort<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>tc", ":TailwindColors<CR>", { noremap = true, silent = true })
		end
	end,
}
