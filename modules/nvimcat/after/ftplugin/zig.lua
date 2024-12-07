-- Exit if the language server isn't available
if vim.fn.executable("zls") ~= 1 then
	return
end

local root_files = {
	"build.zig",
}

local lspconfig = require("lspconfig")
lspconfig.zls.setup({})

vim.lsp.start({
	name = "zls",
	cmd = { "zls" },
	root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
	capabilities = require("user.lsp").make_client_capabilities(),
})
