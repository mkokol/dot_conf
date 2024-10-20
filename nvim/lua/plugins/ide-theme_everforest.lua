---@diagnostic disable: unused-local

return {
	"neanias/everforest-nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- Optionally configure and load the colorscheme
		local everforest = require("everforest")
		everforest.setup({
			background = "hard",
			transparent_background_level = 0,
			italics = false,
			disable_italic_comments = false,
			sign_column_background = "none",
			ui_contrast = "low",

			dim_inactive_windows = false,
			diagnostic_text_highlight = false,
			diagnostic_virtual_text = "coloured",
			diagnostic_line_highlight = false,
			spell_foreground = false,
			show_eob = true,
			float_style = "bright",
			inlay_hints_background = "none",
			on_highlights = function(highlight_groups, palette) end,
			colours_override = function(palette) end,
		})
		everforest.load()
	end,
}

-- return {
-- 	"sainnhe/sonokai",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		-- Optionally configure and load the colorscheme
-- 		-- directly inside the plugin declaration.
-- 		vim.g.sonokai_enable_italic = true
-- 		vim.g.sonokai_style = "espresso"
-- 		vim.g.sonokai_better_performance = 1
--
-- 		vim.cmd.colorscheme("sonokai")
-- 	end,
-- }
