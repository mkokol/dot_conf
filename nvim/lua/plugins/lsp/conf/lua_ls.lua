return {
	config = function(capabilities)
		if not (_G.UserConfig.lsp and _G.UserConfig.lsp.lua == true) then
			return
		end

		vim.lsp.config("lua_ls", {
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" },
			capabilities = capabilities,
			filetypes = { "lua" },
			root_markers = {
				"init.lua",
			},
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
						library = {
							vim.fn.stdpath("config"),
							vim.env.VIMRUNTIME,
						},
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
}
