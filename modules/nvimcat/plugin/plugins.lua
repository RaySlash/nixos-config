if vim.g.did_load_plugins_plugin then
	return
end
vim.g.did_load_plugins_plugin = true

vim.filetype.add({
	pattern = { [".*/*/.*%.yuck"] = "yuck" },
})

vim.filetype.add({
	pattern = { [".*%.purs"] = "purescript" },
})

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

require("nvim-surround").setup()
require("which-key").setup()
require("autoclose").setup()
require("nvim-ts-autotag").setup()
