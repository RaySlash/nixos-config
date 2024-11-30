-- Exit if the language server isn't available
if vim.fn.executable("ccls") ~= 1 then
	return
end

local root_files = {
	"main.cc",
}

vim.lsp.start({
	name = "ccls",
	cmd = { "ccls" },
	root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
	capabilities = require("user.lsp").make_client_capabilities(),
})
