if vim.g.did_load_neotree_plugin then
	return
end
vim.g.did_load_neotree_plugin = true

-- To enable image file previews
local image = require("image")
image.setup({
	processor = "magick_cli",
})

local neotree = require("neo-tree")
neotree.setup({
	window = {
		position = "right",
		mappings = {
			["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { noremap = true, silent = true, desc = "neo[g]it open" })
