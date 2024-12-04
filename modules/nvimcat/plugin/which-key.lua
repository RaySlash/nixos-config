if vim.g.did_load_whichkey_plugin then
	return
end
vim.g.did_load_whichkey_plugin = true

require("which-key").setup({
	preset = "helix",
})
