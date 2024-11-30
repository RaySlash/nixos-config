if vim.g.did_load_hyprlang_plugin then
  return
end
vim.g.did_load_hyprlang_plugin = true

-- TODO: Migrate to ftplugin
vim.filetype.add {
  pattern = { ['.*/*/hyprland.conf'] = 'hyprlang', ['.*/*/hyprpaper.conf'] = 'hyprlang' },
}
