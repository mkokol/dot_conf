vim.cmd("let g:netrw_liststyle = 3") -- represent defoult neovim explorer as a tree
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register
vim.g.opentTermCout = 0

-- tabs & indentation
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.tabstop = 4 -- n spaces for tabs (prettier default)
vim.opt.shiftwidth = 4 -- n spaces for indent width

-- common styling
vim.opt.showmode = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift
vim.opt.colorcolumn = "80,120"
vim.opt.scrolloff = 16 -- keep extra lines from top and bottom when moving cursor

vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift

vim.opt.list = true
---@diagnostic disable-next-line: missing-fields
vim.opt.listchars = {
	tab = "» ",
	space = "·",
	trail = "",
	eol = "󱞥",
}

-- turn off swapfile
vim.opt.swapfile = false

-- backspace
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- change the diagnostic symbols in the sign column (gutter)
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "Error",
			[vim.diagnostic.severity.WARN] = "Warn",
			[vim.diagnostic.severity.INFO] = "Info",
			[vim.diagnostic.severity.HINT] = "Hint",
		},
	},
})
