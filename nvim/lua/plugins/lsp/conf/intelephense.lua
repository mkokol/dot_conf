return {
	setup = function(lspconfig, capabilities)
		lspconfig.intelephense.setup({
			capabilities = capabilities,
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
			},
		})
	end,
}
