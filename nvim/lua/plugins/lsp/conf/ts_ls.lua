return {
	config = function(capabilities)
		local mason_volar_path = "~/.local/share/nvim/mason/packages/vue-language-server/"

		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						languages = { "vue" },
						location = vim.fn.expand(mason_volar_path .. "/node_modules/@vue/language-server"),
					},
				},
			},
			root_dir = vim.fs.dirname(vim.fs.find({ "package.json", "tsconfig.json", ".git" }, { upward = true })[1]),
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		})
	end,
}
