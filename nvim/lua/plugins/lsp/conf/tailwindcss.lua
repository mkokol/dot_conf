return {
	config = function(capabilities)
		vim.lsp.config("tailwindcss", {
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
			root_dir = vim.fs.dirname(
				vim.fs.find({ "tailwind.config.js", "tailwind.config.ts", "package.json", ".git" }, { upward = true })[1]
			),
		})
	end,
}
