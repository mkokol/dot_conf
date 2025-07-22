vim.g.mapleader = " "

vim.keymap.set("n", "<leader>m", "<cmd>Maven<cr>", { desc = "Show [M]aven menu" })

vim.keymap.set({ "n", "i", "v" }, "<Esc><Esc>", function()
	vim.cmd("nohlsearch") -- Clear search highlights
end, { desc = "Clear search highlights" })

-- vim.keymap.set("n", "<A-j>", "<C-d>", { desc = "Scroll Down" })
-- vim.keymap.set("n", "<A-k>", "<C-u>", { desc = "Scroll Up" })

vim.keymap.set("n", "<leader>lo", "<cmd>Lazy<cr>", { desc = "[L]azy window [O]pen" })
vim.keymap.set("n", "<leader>mo", "<cmd>Mason<cr>", { desc = "[M]ason window [O]pen" })
