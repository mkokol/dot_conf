return {
	-- https://github.com/neanias/everforest-nvim
	-- theme
	{
		"neanias/everforest-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local everforest = require("everforest")
			everforest.setup({
				background = "hard",
				transparent_background_level = 0,
				italics = false,
				disable_italic_comments = false,
				sign_column_background = "none",
				ui_contrast = "low",

				dim_inactive_windows = false,
				diagnostic_text_highlight = false,
				diagnostic_virtual_text = "coloured",
				diagnostic_line_highlight = false,
				spell_foreground = false,
				show_eob = true,
				float_style = "bright",
				inlay_hints_background = "none",
				on_highlights = function(_) end,
				colours_override = function(_) end,
			})
			everforest.load()
		end,
	},

	-- https://github.com/goolord/alpha-nvim
	-- intro page
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			alpha.setup(dashboard.config)
		end,
	},

	-- https://github.com/folke/noice.nvim
	-- lsp notifications
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				override_vim_notify = true, -- This routes LSP notifications to nvim-notify
			},
		},
	},

	-- https://github.com/j-hui/fidget.nvim
	-- popup & notifications
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },

	-- https://github.com/folke/noice.nvim
	-- project folder tree
	{
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
	},

	-- https://github.com/akinsho/bufferline.nvim
	-- tabs
	{
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

			vim.keymap.set("n", "<A-,>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev tab" })
			vim.keymap.set("n", "<A-.>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next tab" })
			vim.keymap.set("n", "<C-,>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move tab left" })
			vim.keymap.set("n", "<C-.>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move tab right " })
			vim.keymap.set("n", "<A-c>", "<cmd>bd|bprev<cr>", { desc = "Close current tab" })

			vim.keymap.set("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Make tab 1 active" })
			vim.keymap.set("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Make tab 2 active" })
			vim.keymap.set("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Make tab 3 active" })
			vim.keymap.set("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Make tab 4 active" })
			vim.keymap.set("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Make tab 5 active" })
			vim.keymap.set("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "Make tab 6 active" })
		end,
	},

	-- https://github.com/nvim-lualine/lualine.nvim
	-- status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local lualine = require("lualine")
			local lazy_status = require("lazy.status") -- to configure lazy pending updates count

			lualine.setup({
				sections = {
					lualine_x = {
						{
							"rest",
							icon = "",
							fg = "#428890",
						},
						{
							lazy_status.updates,
							cond = lazy_status.has_updates,
							color = { fg = "#ff9e64" },
						},
						{ "encoding" },
						{ "fileformat" },
						{ "filetype" },
					},
				},
				options = {
					-- ... other configuration
					theme = "everforest", -- Can also be "auto" to detect automatically.
				},
			})
		end,
	},
}
