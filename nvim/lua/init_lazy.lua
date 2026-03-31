local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"

local function load_json(filename)
	local path = vim.fn.stdpath("config") .. "/" .. filename
	local f = io.open(path, "r")

	if not f then
		return {}
	end

	local content = f:read("*a")
	f:close()

	local ok, decoded = pcall(vim.fn.json_decode, content)
	return (ok and type(decoded) == "table") and decoded or {}
end

local base_config = load_json("config.json")
local local_config = load_json("config.local.json")
_G.UserConfig = vim.tbl_deep_extend("force", base_config, local_config)

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.lsp.plugins" },
		{ import = "plugins.lsp" },
		{ import = "plugins.ai" },
	},
	-- automatically check for plugin updates
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

vim.keymap.set("n", "<leader>lo", "<cmd>Lazy<cr>", { desc = "[L]azy window [O]pen" })
