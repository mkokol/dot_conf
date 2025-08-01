return {
	-- https://github.com/zbirenbaum/copilot.lua
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				copilot_node_command = os.getenv("HOME") .. "/.asdf/installs/nodejs/22.17.1/bin/node",
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},

	-- https://github.com/zbirenbaum/copilot-cmp
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- https://github.com/olimorris/codecompanion.nvim
	-- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
	{
		"olimorris/codecompanion.nvim",
		opts = {
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-sonnet-4",
							},
						},
					})
				end,
			},
			display = {
				diff = {
					enabled = true,
				},
				chat = {
					show_settings = true,
					window = {
						layout = "float", -- float|vertical|horizontal|buffer
						width = 0.8,
						height = 0.8,
					},
				},
			},
			opts = {
				-- Set debug logging
				log_level = "DEBUG",
			},
		},
		dependencies = {
			"zbirenbaum/copilot.lua",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CompanionChat - Show actions popUp" },
			{ "<leader>aw", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CompanionChat - Show chat popUp" },
		},
	},
}
