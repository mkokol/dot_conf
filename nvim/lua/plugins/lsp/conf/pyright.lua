return {
	config = function(capabilities)
		if not (_G.UserConfig.lsp and _G.UserConfig.lsp.python == true) then
			return
		end

		vim.lsp.config("pyright", {
			cmd = { "pyright-langserver", "--stdio" },
			capabilities = capabilities,
			filetypes = { "python" },
			root_markers = {
				"pyproject.toml",
				".venv",
				".git",
			},
			single_file_support = true,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace",
						reportOptionalSubscript = false,
						reportOptionalMemberAccess = false,
					},
					venv = ".venv",
					venvPath = ".",
					pythonPath = "./.venv/bin/python",
				},
			},
		})
	end,
}
