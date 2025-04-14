return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local function calculate_tree_width()
			local screen_width = vim.o.columns

			return math.floor(screen_width * 0.26)
		end

		local nvimtree = require("nvim-tree")

		nvimtree.setup({
			view = {
				number = false,
				-- relativenumber = true,
				-- width = 38,
				-- adaptive_size = true,
				width = calculate_tree_width,
			},
			renderer = {
				group_empty = true,
				indent_markers = {
					enable = true,
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
		vim.keymap.set("n", "<leader>ef", function()
			local api = require("nvim-tree.api")
			api.tree.close()
			api.tree.find_file({ open = true, update_root = true })
		end, { desc = "Always reopen explorer focused on current file" })
		vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<cr>", { desc = "Collapse explorer" })
		vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh explorer" })
	end,
}
