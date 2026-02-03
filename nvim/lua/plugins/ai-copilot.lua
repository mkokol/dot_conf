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
		dependencies = {
			"zbirenbaum/copilot.lua",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"lalitmee/codecompanion-spinners.nvim",
		},
		opts = {
			log_level = "DEBUG",

			adapters = {
				http = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = {
								model = {
									default = "claude-opus-4.5",
								},
							},
						})
					end,
				},
			},

			rules = {
				default = {
					description = "Collection of common files for all projects",
					files = {
						".rules",
						"AGENT.md",
						"AGENTS.md",
						".agents/AGENTS.md",
						vim.fn.expand("~/.agents/AGENTS.md"),
					},
				},
			},

			display = {
				diff = {
					enabled = true,
					provider = "mini_diff", -- mini_diff|split|inline
				},
				chat = {
					show_settings = true,
					window = {
						layout = "float", -- float|vertical|horizontal|buffer
						width = 0.86,
						height = 0.86,
					},
				},
			},

			extensions = {
				spinner = {
					enabled = true,
					style = "cursor-relative",
					color = "DiagnosticInfo",
				},
			},
		},
		keys = {
			{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CompanionChat - Show actions popUp" },
			{ "<leader>aw", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CompanionChat - Show chat popUp" },
			{
				"<leader>ar",
				"<cmd>lua require('codecompanion').config.commands.ReloadAgents()<cr>",
				desc = "Reload AGENTS.md memory",
			},
		},
	},
}
