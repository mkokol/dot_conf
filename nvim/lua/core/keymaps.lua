vim.g.mapleader = " "

vim.keymap.set("n", "<leader>m", "<cmd>Maven<cr>", { desc = "Show [M]aven menu" })

vim.keymap.set({ "n", "i", "v" }, "<Esc><Esc>", function()
	vim.cmd("nohlsearch") -- Clear search highlights
end, { desc = "Clear search highlights" })

vim.api.nvim_set_keymap('n', '<A-j>', '<C-d>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', '<C-u>', { noremap = true, silent = true })

