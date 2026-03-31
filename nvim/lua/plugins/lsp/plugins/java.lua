return {
	-- https://github.com/eatgrass/maven.nvim
	-- maven command support with manu
	{
		"eatgrass/maven.nvim",
		enabled = _G.UserConfig.lsp and _G.UserConfig.lsp.java == true,
		cmd = { "Maven", "MavenExec" },
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("maven").setup({
				executable = "mvn",
			})

			vim.keymap.set("n", "<leader>mc", "<cmd>Maven<cr>", { desc = "Show [M]aven [M]enu" })
		end,
	},
}
