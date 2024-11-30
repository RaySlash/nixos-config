if vim.g.did_load_lualine_plugin then
	return
end
vim.g.did_load_lualine_plugin = true

require("lualine").setup({
	globalstatus = true,
	options = {
		theme = "auto",
	},
	extensions = { "fugitive", "fzf", "toggleterm", "quickfix" },
})
