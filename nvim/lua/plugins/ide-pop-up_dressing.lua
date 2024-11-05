return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	config = function()
		local dressing = require("dressing")

		dressing.setup({
			input = {
				relative = "editor",
				prefer_width = 60,
			},
		})
	end,
}
