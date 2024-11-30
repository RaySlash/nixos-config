local rust_analyzer_cmd = 'rust-analyzer'

-- Check if rust-analyzer is available
if vim.fn.executable(rust_analyzer_cmd) ~= 1 then
  return
end

local root_files = {
  'Cargo.lock',
  'Cargo.toml',
  '.git',
}

vim.lsp.start {
  name = 'rust_analyzer',
  cmd = { rust_analyzer_cmd },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = {
    ['rust-analyzer'] = {
      assist = {
        importGranularity = 'module',
        importPrefix = 'by_self',
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
}
