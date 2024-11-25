-- General
vim.keymap.set("n", "<C-q>", "<cmd>q!<cr>", { desc = "Quit", noremap = true })
vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>", { desc = "Open Neogit", noremap = true })

-- Telescope
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope Grep-Live" })
