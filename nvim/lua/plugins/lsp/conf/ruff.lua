-- ruff lsp repo: https://github.com/astral-sh/ruff

return {
	config = function(capabilities)
		if not (_G.UserConfig.lsp and _G.UserConfig.lsp.python == true) then
			return
		end

		vim.lsp.config("ruff", {
			capabilities = capabilities,
			-- available settings https://docs.astral.sh/ruff/editors/settings/
			settings = {
				organizeImports = true,
				codeAction = {
					fixAll = true,
				},
				lint = {
					enable = true,
				},
			},
			root_makers = { ".venv", ".git" },
		})
	end,
}
