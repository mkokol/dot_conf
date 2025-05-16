if vim.g.pyright_configured then
	return
end

vim.g.pyright_configured = true

local file_dir = vim.fn.expand("%:p:h")
local root_init_files = { ".venv", ".pylintrc", "requirements.txt", "pyrightconfig.json" }
local root_dir = vim.fs.dirname(vim.fs.find(root_init_files, { upward = true, path = file_dir })[1])

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.pyright.setup({
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
				reportOptionalSubscript = false,
				reportOptionalMemberAccess = false,
			},
			pythonPath = root_dir .. "/.venv/bin/python",
			venvPath = root_dir,
			venv = ".venv",
		},
	},
	root_dir = function()
		return root_dir
	end,
})

local lint = require("lint")

-- Configure Pylint with custom .pylintrc file
---@diagnostic disable-next-line: missing-fields
lint.linters.pylint = {
	cmd = "pylint", -- Ensure pylint is installed and available
	args = {
		"--rcfile",
		root_dir .. "/.pylintrc", -- Path to your .pylintrc file
		"--output-format",
		"text", -- Output format (you can use "text", "json", etc.)
		"--",
		"$FILENAME", -- Use the current file
	},
	filetypes = { "python" }, -- Ensure pylint runs for Python files
}
