return {

	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim", -- telescop mandatory dependency
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"princejoogie/dir-telescope.nvim",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod

		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")

		-- or create your custom action
		local custom_actions = transform_mod({
			---@diagnostic disable-next-line: unused-local
			open_trouble_qflist = function(prompt_bufnr)
				trouble.toggle("quickfix")
			end,
		})

		telescope.setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = "❯ ",
				color_devicons = true,
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
					width = 0.94,
					horizontal = {
						prompt_position = "top",
						preview_width = 0.7,
						results_width = 0.3,
					},
					vertical = {
						mirror = false,
					},
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-a>"] = actions.select_all,
						["<C-t>"] = trouble_telescope.open,
					},
				},
				preview = {
					filesize_limit = 0.01, -- MB
					timeout = 100, -- ms
				},
				additional_args = { "--hidden" },
				file_ignore_patterns = {
					"\\.git",
					"node_modules",
					"target",
					"test",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("dir")

		-- set keymaps
		vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]ind [F]iles in cwd" })
		vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [S]tring in cwd" })
		vim.keymap.set("n", "<leader>fo", "<cmd>Telescope buffers<cr>", { desc = "[F]ind [O]pen Buffers" })
		vim.keymap.set("n", "<leader>fd", "<cmd>GrepInDirectory<CR>", { desc = "[F]ind in [D]ir" })
		vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[F]ind [T]odos" })
	end,
}
