return {
	-- https://github.com/zbirenbaum/copilot.lua
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				copilot_node_command = os.getenv("HOME") .. "/.nvm/versions/node/v22.14.0/bin/node",
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},

	-- https://github.com/zbirenbaum/copilot-cmp
	{
		"zbirenbaum/copilot-cmp",
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
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CompanionChat - Show actions popUp" },
			{ "<leader>aw", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CompanionChat - Show chat popUp" },
		},
	},

	-- https://github.com/CopilotC-Nvim/CopilotChat.nvim
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	branch = "main",
	-- 	dependencies = {
	-- 		{ "zbirenbaum/copilot.lua" },
	-- 		{ "nvim-lua/plenary.nvim", branch = "master" },
	-- 		{ "nvim-telescope/telescope.nvim" },
	-- 	},
	-- 	build = "make tiktoken",
	-- 	opts = {
	-- 		model = "claude-sonnet-4",
	-- 		window = {
	-- 			layout = "float",
	-- 			width = 0.9,
	-- 			height = 0.8,
	-- 		},
	-- 		mappings = {
	-- 			complete = {
	-- 				insert = "<Tab>",
	-- 			},
	-- 			show_diff = {
	-- 				full_diff = true,
	-- 				normal = "<Leader>d",
	-- 			},
	-- 			accept_diff = {
	-- 				normal = "<Leader>s",
	-- 			},
	-- 			reset = {
	-- 				normal = "<Leader>r",
	-- 			},
	-- 		},
	-- 	},
	-- 	keys = {
	-- 		{ "<leader>aw", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle PopUp" },
	-- 		{ "<leader>am", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
	-- 		{ "<leader>aa", "<cmd>CopilotChatAgents<cr>", desc = "CopilotChat - Select Agents" },
	-- 		{ "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
	-- 	},
	-- },
}
