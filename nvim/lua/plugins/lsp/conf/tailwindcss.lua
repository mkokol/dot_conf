return {
	config = function(capabilities)
		if not (_G.UserConfig.lsp and _G.UserConfig.lsp.tailwind == true) then
			return
		end

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
