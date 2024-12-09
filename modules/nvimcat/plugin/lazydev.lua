if vim.g.did_load_lazydev_plugin then
	return
end
vim.g.did_load_lazydev_plugin = true

require("lazydev").setup({
	enabled = function(root_dir)
		return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
	end,
	-- Only load luvit types when the `vim.uv` word is found
	{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
})
