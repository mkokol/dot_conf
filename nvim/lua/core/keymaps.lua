vim.g.mapleader = " "

vim.keymap.set({ "n", "i", "v" }, "<Esc><Esc>", function()
	vim.cmd("nohlsearch") -- Clear search highlights
end, { desc = "Clear search highlights" })

vim.keymap.set({ "n", "v" }, "J", "<C-d>", { desc = "Scroll Down" })
vim.keymap.set({ "n", "v" }, "K", "<C-u>", { desc = "Scroll Up" })

vim.keymap.set("n", "<leader>sf", "<cmd>w<cr>", { desc = "[S]ave [F]ile" })
vim.keymap.set("n", "<leader>sa", "<cmd>wa<cr>", { desc = "[S]ave [A]ll" })
