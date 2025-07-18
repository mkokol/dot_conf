return {
	-- https://github.com/tpope/vim-fugitive
	-- git commands in vim: [:G or :Git] + gitcommand
	{
		"tpope/vim-fugitive",
	},

	-- https://github.com/lewis6991/gitsigns.nvim
	-- git info overview in vim
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()

			vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "[G]it preview hunk" })
			vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame<cr>", { desc = "[G]it [B]lame" })

			-- Toggles
			vim.keymap.set(
				"n",
				"<leader>tb",
				"<cmd>Gitsigns toggle_current_line_blame<cr>",
				{ desc = "[T]oggle line [B]lame" }
			)
			vim.keymap.set("n", "<leader>tw", "<cmd>Gitsigns toggle_word_diff<cr>", { desc = "[T]oggle [W]ord diff" })
		end,
	},
}
