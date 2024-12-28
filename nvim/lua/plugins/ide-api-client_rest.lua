return {
	"rest-nvim/rest.nvim",
	config = function()
		-- Set options using vim.g for rest-nvim
		vim.g.rest_nvim = {
			result_split_horizontal = true, -- Show result in a vertical split
			-- skip_ssl_verification = true, -- Useful for self-signed certificates
			encode_url = true, -- Automatically encode URLs before sending requests
			highlight = { -- Customize highlighting for response
				enabled = true,
				timeout = 600,
			},
			-- jump_to_request = false, -- Keeps cursor at the request when you send it
			env_file = ".env", -- Specify environment file location
			custom_dynamic_variables = {}, -- Add custom dynamic variables here
			yank_dry_run = false, -- Preview yank without modifying clipboard
			response = {
				hooks = {
					decode_url = true,
					format = true,
				},
			},
			show_headers = true,
		}

		vim.bo.formatexpr = ""
		vim.bo.formatprg = "jq"

		-- Optionally set key mappings for `rest-nvim` commands
		vim.api.nvim_set_keymap("n", "<leader>rr", "<cmd>Rest run<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>rf", [[:%!jq .<CR>]], { noremap = true, silent = true })
	end,
}
