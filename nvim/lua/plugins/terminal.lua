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

		vim.keymap.set("n", "<leader>t1", ":ToggleTerm 1<CR>", { desc = "" })
		vim.keymap.set("n", "<leader>t2", ":ToggleTerm 2<CR>", { desc = "" })
		vim.keymap.set("n", "<leader>t3", ":ToggleTerm 3<CR>", { desc = "" })
		vim.keymap.set("n", "<leader>t4", ":ToggleTerm 4<CR>", { desc = "" })
		vim.keymap.set("n", "<leader>t5", ":ToggleTerm 5<CR>", { desc = "" })

		-- Toggle terminal visibility in normal mode
		vim.keymap.set("n", "<leader>th", ":ToggleTermToggleAll<CR>", { desc = "" })

		-- Toggle terminal visibility in terminal mode
		vim.keymap.set("t", "<leader>th", "<C-\\><C-n>:ToggleTermToggleAll<CR>", { desc = "" })

		vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "" })
	end,
}
