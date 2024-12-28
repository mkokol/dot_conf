return {
	setup = function(lspconfig, capabilities)
		lspconfig.volar.setup({
			capabilities = capabilities,
			settings = {
				css = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
				scss = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		})
	end,
}
