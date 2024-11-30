if vim.fn.executable('elm-language-server') ~= 1 then
  return
end

local root_files = {
  'elm.json',
  '.git',
}

vim.lsp.start {
  name = 'elm-language-server',
  cmd = { 'elm-language-server' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
}
