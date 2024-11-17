if vim.g.did_load_gruvbox_plugin then
  return
end
vim.g.did_load_gruvbox_plugin = true

require("gruvbox").setup({
  contrast = "hard",
  palette_overrides = {},
  transparent_mode = true,
})

vim.cmd("colorscheme gruvbox")
