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
		dependencies = {
			"nvim-lua/plenary.nvim", -- telescop mandatory dependency
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

			"nvim-telescope/telescope-file-browser.nvim",

			"folke/todo-comments.nvim",
			"nvim-telescope/telescope-ui-select.nvim", -- used for lsp dropdown
			"MunifTanjim/nui.nvim", -- for better border control
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local trouble = require("trouble")

			local Layout = require("nui.layout")
			local Popup = require("nui.popup")
			local TSLayout = require("telescope.pickers.layout")

			telescope.setup({
				defaults = {
					prompt_prefix = "  ",
					selection_caret = "❯ ",
					color_devicons = true,
					sorting_strategy = "ascending",
					path_display = { "filename_first" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-a>"] = actions.select_all,
							-- ["<C-q>"] = function(bufnr)
							-- 	actions.send_selected_to_qflist(bufnr)
							-- 	trouble.toggle("quickfix")
							-- end,
							["<esc><esc>"] = actions.close,
						},
					},
					preview = {
						filesize_limit = 0.1, -- MB
						timeout = 500, -- ms
					},
					additional_args = { "--hidden" },
					file_ignore_patterns = {
						"%.git", -- git functional files
						"node_modules/", -- frontend packages
						"%.venv/", -- python virtual environment
						"build/", -- java build folder including build/generated
					},

					-- idea from https://github.com/nvim-telescope/telescope.nvim/pull/2572
					create_layout = function(picker)
						local preview = Popup({
							focusable = false,
							border = {
								style = { "┌", "─", "┐", "│", "", "", "", "│" },
								text = {
									top = picker.preview_title,
								},
							},
						})
						local prompt = Popup({
							enter = true,
							border = {
								style = { "├", "─", "┤", "│", "", "", "", "│" },
								text = {
									top = picker.prompt_title,
								},
							},
							win_options = {
								winhighlight = "Normal:Normal",
							},
						})
						local results = Popup({
							focusable = false,
							border = {
								style = { "├", "─", "┤", "│", "┘", "─", "└", "│" },
								text = {
									top = picker.results_title,
								},
							},
						})

						local box = Layout.Box({
							Layout.Box(preview, { grow = 1 }),
							Layout.Box(prompt, { size = 2 }),
							Layout.Box(results, { size = 15 }),
						}, { dir = "col" })

						local layout = Layout({
							relative = "editor",
							position = "50%",
							size = {
								height = "94%",
								width = "94%",
							},
						}, box)

						layout.picker = picker
						layout.results = TSLayout.Window(results)
						layout.prompt = TSLayout.Window(prompt)
						layout.preview = TSLayout.Window(preview)

						local layout_update = layout.update
						function layout:update()
							layout_update(box)
						end

						return TSLayout(layout)
					end,
				},
				extensions = {
					fzf = {
						fuzzy = true,
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					file_browser = {
						previewer = true,
						grouped = true,
						hidden = true,
						use_fd = false,
						hijack_netrw = false,
						respect_gitignore = false,
						initial_mode = "normal",
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
			telescope.load_extension("file_browser")

			-- set keymaps
			-- search related
			vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]ind [F]iles in cwd" })
			vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [S]tring in cwd" })
			vim.keymap.set("n", "<leader>fo", "<cmd>Telescope buffers<cr>", { desc = "[F]ind [O]pen Buffers" })
			vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[F]ind [T]odos" })
			vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "[F]ind [H]elp" })
			vim.keymap.set("n", "<leader>fa", function()
				require("telescope.builtin").find_files({
					no_ignore = true,
					hidden = true,
				})
			end, { desc = "[F]ind [A]ll files, including hidden and ignored" })

			-- lsp related
			vim.keymap.set(
				"n",
				"<leader>dw",
				"<cmd>Telescope diagnostics<CR>",
				{ desc = "[D]iscover diagnostics in [W]orkspace" }
			)
			vim.keymap.set(
				"n",
				"<leader>df",
				"<cmd>Telescope diagnostics bufnr=0<CR>",
				{ desc = "[D]iscover [F]ile diagnostic in active buffer" }
			)
			vim.keymap.set(
				"n",
				"<leader>dr",
				"<cmd>Telescope lsp_references<CR>",
				{ desc = "[D]iscover LSP [R]eferences" }
			)
			vim.keymap.set(
				"n",
				"<leader>dd",
				"<cmd>Telescope lsp_definitions<CR>",
				{ desc = "[D]iscover LSP [D]efinitions" }
			)
			vim.keymap.set(
				"n",
				"<leader>di",
				"<cmd>Telescope lsp_implementations<CR>",
				{ desc = "[D]iscover LSP [I]mplementations" }
			)
			vim.keymap.set(
				"n",
				"<leader>dt",
				"<cmd>Telescope lsp_type_definitions<CR>",
				{ desc = "[D]iscover LSP [T]ype definitions" }
			)

			-- opts.desc = "Show LSP implementations"
			-- keymap.set("n", "gi", "<cmd>Telescope <CR>", opts)
			--
			-- opts.desc = "Show LSP type definitions"
			-- keymap.set("n", "gt", "<cmd>Telescope <CR>", opts)
			--
			--
			-- require('telescope.builtin').lsp_document_symbols({ symbols = "Function" }
		end,
	},
}
