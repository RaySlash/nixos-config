if vim.g.did_load_trouble_plugin then
	return
end
vim.g.did_load_trouble_plugin = true

local keymap = vim.keymap

require("trouble").setup({})
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", {
	desc = "Diagnostics (Trouble)",
	noremap = true,
	silent = true,
})
keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {
	desc = "Buffer Diagnostics (Trouble)",
	noremap = true,
	silent = true,
})
keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", {
	desc = "Symbols (Trouble)",
	noremap = true,
	silent = true,
})
keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", {
	desc = "LSP Definitions / References (Trouble)",
	noremap = true,
	silent = true,
})
keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", {
	desc = "Location List (Trouble)",
	noremap = true,
	silent = true,
})
keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", {
	desc = "Quickfix List (Trouble)",
	noremap = true,
	silent = true,
})
