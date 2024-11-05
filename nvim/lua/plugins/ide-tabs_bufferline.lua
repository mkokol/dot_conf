return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	version = "*",
	config = function()
		require("bufferline").setup({
			options = {
				numbers = "ordinal",
				diagnostics = "nvim_lsp",
				enforce_regular_tabs = true,
				indicator = {
					style = "icon",
					icon = " ",
				},
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				offsets = {
					{
						filetype = "NvimTree",
						highlight = "NvimTreeNormal",
						separator = false,
						text_align = "left",
					},
				},
			},
		})

		vim.keymap.set("n", "<A-,>", "<cmd>BufferLineCyclePrev<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A-.>", "<cmd>BufferLineCycleNext<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A-<>", "<cmd>BufferLineMovePrev<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A->>", "<cmd>BufferLineMoveNext<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A-c>", "<cmd>bd|bprev<cr>", { noremap = true, silent = true })

		vim.keymap.set("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", { noremap = true, silent = true })
	end,
}
