return {
	config = function(_)
		local capabilitiesCssls = vim.lsp.protocol.make_client_capabilities()
		capabilitiesCssls.textDocument.completion.completionItem.snippetSupport = true
		capabilitiesCssls.textDocument.completion.completionItem.resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
			},
		}

		vim.lsp.config("lua_ls", {
			capabilities = capabilitiesCssls,
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
				vue = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		})
	end,
}
