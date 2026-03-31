return {
	{
		"greggh/claude-code.nvim",
		enabled = _G.UserConfig.ai and _G.UserConfig.ai.claude == true,
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for git operations
		},
		config = function()
			require("claude-code").setup({
				window = {
					split_ratio = 0.4,
				},
				git = {
					use_git_root = false, -- Set CWD to git root when opening Claude Code (if in git project)
				},
			})

			vim.keymap.set("n", "<leader>aw", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })
		end,
	},
}
