return {
	setup = function(lspconfig, capabilities)
		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
			filetypes = {
				"css",
				"scss",
				"postcss",
				"html",
				"vue",
				"javascriptreact",
				"typescriptreact",
			},
			root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "package.json", ".git"),
		})
	end,
}
