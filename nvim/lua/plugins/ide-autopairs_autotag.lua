return {
	"windwp/nvim-ts-autotag",
	event = { "InsertEnter" },
	config = function()
		local autotag = require("nvim-ts-autotag")
		---@diagnostic disable-next-line: missing-fields
		autotag.setup({
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
		})
	end,
}
