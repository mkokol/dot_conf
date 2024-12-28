-- https://github.com/krshrimali/nvim/blob/master/lua/user/toggleterm.lua
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			--direction = "horizontal",
			direction = "float",
			-- use leader t to toggle terminal
			open_mapping = [[<leader>to]],
			start_in_insert = false,
			-- close_on_exit = false,
			autochdir = true,
			shell = vim.o.shell,
			size = 20,
			on_create = function()
				vim.g.opentTermCout = vim.g.opentTermCout + 1
			end,
			on_close = function()
				vim.g.opentTermCout = vim.g.opentTermCout - 1
			end,
		})

		vim.api.nvim_set_keymap("n", "<leader>t1", ":ToggleTerm 1<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>t2", ":ToggleTerm 2<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>t3", ":ToggleTerm 3<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>t4", ":ToggleTerm 4<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>t5", ":ToggleTerm 5<CR>", { noremap = true, silent = true })

		-- Toggle terminal visibility in normal mode
		vim.api.nvim_set_keymap("n", "<leader>th", ":ToggleTermToggleAll<CR>", { noremap = true, silent = true })

		-- Toggle terminal visibility in terminal mode
		vim.api.nvim_set_keymap(
			"t",
			"<leader>th",
			"<C-\\><C-n>:ToggleTermToggleAll<CR>",
			{ noremap = true, silent = true }
		)

		vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
	end,
}
