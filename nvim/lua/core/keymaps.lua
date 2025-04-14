vim.g.mapleader = " "

vim.keymap.set("n", "<leader>m", "<cmd>Maven<cr>", { desc = "Show [M]aven menu" })

vim.keymap.set({ "n", "i", "v" }, "<Esc><Esc>", function()
	vim.cmd("nohlsearch") -- Clear search highlights
end, { desc = "Clear search highlights" })
