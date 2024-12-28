return {
	setup = function(lspconfig, capabilities)
		local mason_volar_path = "~/.local/share/nvim/mason/packages/vue-language-server/"

		lspconfig["ts_ls"].setup({
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
			root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		})
	end,
}
