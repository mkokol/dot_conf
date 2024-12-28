return {
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
}
