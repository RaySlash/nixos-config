local tsserver_cmd = 'typescript-language-server'

-- Check if typescript-language-server is available
if vim.fn.executable(tsserver_cmd) ~= 1 then
  return
end

local root_files = {
  'tsconfig.json',
  'jsconfig.json',
  'package.json',
  '.git',
}

vim.lsp.start {
  name = 'tsserver',
  cmd = { tsserver_cmd, '--stdio' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = {
    documentFormatting = false,
    completions = {
      completeFunctionCalls = true,
    },
  },
}
