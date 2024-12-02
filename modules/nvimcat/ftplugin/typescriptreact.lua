local typescript_language_server_cmd = "typescript-language-server"

if vim.fn.executable(typescript_language_server_cmd) ~= 1 then
	return
end

local root_files = {
	".git",
}

local tailwind_root_files = {
  "tailwindcss.config.ts",
	".git",
}

vim.lsp.start({
	name = "tailwindcss-language-server",
	cmd = { "tailwindcss-language-server" },
	root_dir = vim.fs.dirname(vim.fs.find(tailwind_root_files, {upward = true})[1]),
	capabilities = require("user.lsp").make_client_capabilities(),
})

vim.lsp.start({
	name = "typescript-language-server",
	cmd = { typescript_language_server_cmd, "--stdio" },
	root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
	capabilities = require("user.lsp").make_client_capabilities(),
	settings = {
		documentFormatting = false,
		completions = {
			completeFunctionCalls = true,
		},
	},
})
