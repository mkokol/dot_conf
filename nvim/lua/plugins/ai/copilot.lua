return {
	-- https://github.com/zbirenbaum/copilot.lua
	-- copilot setup, is used by othe plugins
	{
		"zbirenbaum/copilot.lua",
		enabled = _G.UserConfig.ai and _G.UserConfig.ai.copilot == true,
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
	-- integrating copilot as auto suggestion
	{
		"zbirenbaum/copilot-cmp",
		enabled = _G.UserConfig.ai and _G.UserConfig.ai.copilot == true,
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
