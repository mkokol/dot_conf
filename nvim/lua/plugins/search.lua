return {
	-- https://github.com/folke/trouble.nvim
	-- pretty list for: diagnostics, references, quickfix, etc.
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
		opts = {
			focus = true,
		},
		cmd = "Trouble",
		keys = {
			{ "<leader>cd", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
			{ "<leader>co", "<cmd>Trouble quickfix<CR>", desc = "Open trouble quickfix" },
		},
		config = function()
			vim.keymap.set("n", "<A-j>", "<cmd>cnext<cr>", { desc = "Next Quickfix" })
			vim.keymap.set("n", "<A-k>", "<cmd>cprev<cr>", { desc = "Prev Quickfix" })
		end,
	},

	-- https://github.com/nvim-telescope/telescope.nvim
	-- highly extendable fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim", -- telescop mandatory dependency
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

			"folke/todo-comments.nvim",
			-- used for lsp dropdown
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local trouble = require("trouble")

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
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-a>"] = actions.select_all,
							["<C-q>"] = function(bufnr)
								actions.send_selected_to_qflist(bufnr)
								trouble.toggle("quickfix")
							end,
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
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")

			-- set keymaps
			-- search related
			vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]ind [F]iles in cwd" })
			vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [S]tring in cwd" })
			vim.keymap.set("n", "<leader>fo", "<cmd>Telescope buffers<cr>", { desc = "[F]ind [O]pen Buffers" })
			vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[F]ind [T]odos" })

			-- lsp related
			vim.keymap.set(
				"n",
				"<leader>dw",
				"<cmd>Telescope diagnostics <CR>",
				{ desc = "[D]iagnostic in [W]orkspace" }
			)
			vim.keymap.set(
				"n",
				"<leader>df",
				"<cmd>Telescope diagnostics bufnr=0<CR>",
				{ desc = "[D]iagnostic in [F]ile in active buffer" }
			)

			-- set keybinds
			-- opts.desc = "Show LSP references"
			-- keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
			--
			-- opts.desc = "Show LSP definitions"
			-- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			--
			-- opts.desc = "Show LSP implementations"
			-- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
			--
			-- opts.desc = "Show LSP type definitions"
			-- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
		end,
	},
}
