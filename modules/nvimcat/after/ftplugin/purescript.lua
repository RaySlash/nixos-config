local purescript_language_server_cmd = "purescript-language-server"

if vim.fn.executable(purescript_language_server_cmd) ~= 1 then
	return
end

local root_files = {
	"spago.dhall",
	"packages.dhal",
	".git",
}

local lspconfig = require("lspconfig")
lspconfig.purescriptls.setup({})

vim.lsp.start({
	name = "purescript-language-server",
	cmd = { purescript_language_server_cmd, "--stdio" },
	root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
	capabilities = require("user.lsp").make_client_capabilities(),
	settings = {
		documentFormatting = false,
		completions = {
			completeFunctionCalls = true,
		},
	},
})
