return {
	-- https://github.com/folke/which-key.nvim
	-- hilight key mapping man
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 100
		end,
		opts = {
			plugins = {
				marks = true,
				registers = true,
			},
		},
	},

	-- https://github.com/numToStr/Comment.nvim
	-- improwed workflow with commenting and uncommenting
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			-- import comment plugin safely
			local comment = require("Comment")

			local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

			-- enable comment
			---@diagnostic disable-next-line: missing-fields
			comment.setup({
				-- for commenting tsx, jsx, svelte, html files
				pre_hook = ts_context_commentstring.create_pre_hook(),
			})
		end,
	},

	-- https://github.com/sontungexpt/url-open
	-- helper to open urel under cursor
	{
		"sontungexpt/url-open",
		event = "VeryLazy",
		cmd = "URLOpenUnderCursor",
		config = function()
			local status_ok, url_open = pcall(require, "url-open")
			if not status_ok then
				return
			end
			url_open.setup({})

			vim.keymap.set("n", "O", "<cmd>URLOpenUnderCursor<cr>", { desc = "" })
		end,
	},
}
