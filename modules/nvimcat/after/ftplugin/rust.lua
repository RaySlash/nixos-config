local rust_analyzer_cmd = "rust-analyzer"

-- Check if rust-analyzer is available
if vim.fn.executable(rust_analyzer_cmd) ~= 1 then
	return
end

local root_files = {
	"Cargo.lock",
	"Cargo.toml",
	".git",
}

local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			lens = { enable = true, implementations = true },
			diagnostics = { enable = true },
			procMacro = {
				enable = true,
				ignored = {
					leptos_macro = {
						"server",
					},
				},
			},
		},
	},
})

vim.lsp.start({
	name = "rust_analyzer",
	cmd = { rust_analyzer_cmd },
	root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
	capabilities = require("user.lsp").make_client_capabilities(),
})
