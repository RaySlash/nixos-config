if vim.g.did_load_yuck_plugin then
  return
end
vim.g.did_load_yuck_plugin = true

-- TODO: Migrate to ftplugin
vim.filetype.add {
  pattern = { ['.*/*/.*%.yuck'] = 'yuck' },
}
