return {
	config = function(capabilities)
		if not (_G.UserConfig.lsp and _G.UserConfig.lsp.cpp == true) then
			return
		end

		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"-j=4",
			},
			capabilities = capabilities,
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			root_markers = {
				"compile_commands.json",
				"compile_flags.txt",
				".git",
			},
			single_file_support = true,
			settings = {
				clangd = {
					-- Add specific fallback flags if you open a file outside a project
					fallbackFlags = { "-std=c++20" },
				},
			},
		})
	end,
}
