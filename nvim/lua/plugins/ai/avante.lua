return {
	-- https://github.com/yetone/avante.nvim
	-- using ai as agent
	{
		"yetone/avante.nvim",
		enabled = _G.UserConfig.ai and _G.UserConfig.ai.avante == true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",

			"zbirenbaum/copilot.lua",

			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
		build = "make",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			log_level = "debug",

			behaviour = {
				auto_add_current_file = false,
			},

			provider = "copilot",
			providers = {
				copilot = {
					model = "claude-opus-4.6",
				},
			},

			windows = {
				width = 50,
				input = {
					prefix = "> ",
					height = 6, -- Height of the input window in vertical layout
				},
			},

			mappings = {
				sidebar = {
					close = { "q", "<Esc><Esc>" },
					close_from_input = { normal = { "q", "<Esc><Esc>" } },
				},
			},
		},
		keys = {
			{ "<leader>aw", "<cmd>AvanteToggle<cr>", desc = "[A]vante toggle chat [W]indow" },
			{ "<leader>anw", "<cmd>AvanteChatNew<cr>", desc = "[A]vante [N]ew chat [W]indow" },
			{ "<leader>am", "<cmd>AvanteModels<cr>", desc = "[A]vante change [M]odel" },
		},
	},
}
