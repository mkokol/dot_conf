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

	-- https://github.com/CopilotC-Nvim/CopilotChat.nvim
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
			{ "nvim-telescope/telescope.nvim" },
		},
		build = "make tiktoken",
		opts = {
			window = {
				layout = "float",
				width = 0.9,
				height = 0.8,
			},
		},
		keys = {
			{ "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
			{ "<leader>aw", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle PopUp" },
			{ "<leader>am", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
			{ "<leader>aa", "<cmd>CopilotChatAgents<cr>", desc = "CopilotChat - Select Agents" },
		},
		mappings = {
			complete = {
				insert = "<Tab>",
			},
			accept_diff = {
				normal = "<Leader>s",
			},
			reset = {
				normal = "<Leader>r",
			},
			show_diff = {
				full_diff = true,
				normal = "<Leader>d",
			},
		},
	},
}
