return {
	{
		"folke/lazydev.nvim",
		enabled = _G.UserConfig.lsp and _G.UserConfig.lsp.lua == true,
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", enabled = _G.UserConfig.lsp and _G.UserConfig.lsp.lua == true, lazy = true },
}
