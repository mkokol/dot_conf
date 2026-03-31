return {
	config = function(capabilities)
		if not (_G.UserConfig.lsp and _G.UserConfig.lsp.java == true) then
			return
		end

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim", "UserConfig" },
					},
					workspace = {
						-- done by lazydev
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
}
