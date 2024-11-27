if vim.g.did_load_neotree_plugin then
  return
end
vim.g.did_load_neotree_plugin = true

local neotree = require('neo-tree')

neotree.setup({})

vim.keymap.set('n', '<leader>e', "<cmd>Neotree toggle<CR>", { noremap = true, silent = true, desc = 'neo[g]it open' })
