return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
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
						["<C-t>"] = trouble_telescope.open,
					},
				},
				file_ignore_patterns = {
					"node_modules",
					"target",
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find open buffers" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
	end,
}
