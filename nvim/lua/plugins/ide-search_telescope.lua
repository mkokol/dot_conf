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
				preview = {
					filesize_limit = 0.01, -- MB
					timeout = 100, -- ms
				},
				file_ignore_patterns = {
					".git",
					"node_modules",
					"target",
					"test",
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		local builtin = require("telescope.builtin")

		local debounce = function(fn, delay)
			local timer = vim.loop.new_timer()
			return function(...)
				local args = { ... }
				timer:stop()
				timer:start(
					delay,
					0,
					vim.schedule_wrap(function()
						fn(unpack(args))
					end)
				)
			end
		end

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		-- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fs", function()
			local start_time
			local debounced_input_filter = debounce(function(prompt_bufnr)
				start_time = vim.loop.hrtime()
				---@diagnostic disable-next-line: redundant-parameter
				local query = require("telescope.actions.state").get_current_line(prompt_bufnr)
				vim.notify(string.format("Searching for: '%s'", query), vim.log.levels.INFO, { title = "Live Grep" })
			end, 300) -- Debounce delay of 300ms

			builtin.live_grep({
				on_input_filter_cb = function(prompt_bufnr)
					debounced_input_filter(prompt_bufnr)
					return {}
				end,
				on_complete = {
					function(prompt_bufnr)
						local end_time = vim.loop.hrtime()
						print(
							string.format(
								"Live grep for query '%s', took %.3f ms",
								prompt_bufnr,
								(end_time - start_time) / 1e6
							)
						)

						---@diagnostic disable-next-line: redundant-parameter
						local query = require("telescope.actions.state").get_current_line(prompt_bufnr)
						vim.notify(
							string.format(
								"Live grep for query '%s', took %.3f ms",
								query,
								(end_time - start_time) / 1e6
							),
							vim.log.levels.INFO,
							{ title = "Live Grep Complete" }
						)
					end,
				},
			})
		end, { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find open buffers" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
	end,
}
