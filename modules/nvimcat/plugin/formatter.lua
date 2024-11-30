if vim.g.did_load_flash_plugin then
	return
end
vim.g.did_load_flash_plugin = true

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- All formatter configurations are opt-in
	filetype = {
		c = {
			require("formatter.filetypes.c").clangformat,
		},
		cpp = {
			require("formatter.filetypes.cpp").clangformat,
		},
		css = {
			require("formatter.filetypes.css").prettierd,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettierd,
		},
		javascriptreact = {
			require("formatter.filetypes.javascriptreact").prettierd,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettierd,
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettierd,
		},
		json = {
			require("formatter.filetypes.json").prettierd,
		},
		markdown = {
			require("formatter.filetypes.markdown").prettierd,
		},
		nix = {
			require("formatter.filetypes.nix").alejandra,
		},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
		},
		sh = {
			require("formatter.filetypes.sh").shfmt,
		},
		sql = {
			require("formatter.filetypes.sql").sql_formatter,
		},
		toml = {
			require("formatter.filetypes.toml").taplo,
		},
		html = {
			require("formatter.filetypes.html").prettierd,
		},
		zig = {
			require("formatter.filetypes.zig").zigfmt,
		},
		yaml = {
			require("formatter.filetypes.yaml").prettierd,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},

		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
			-- Remove trailing whitespace without 'sed'
			-- require("formatter.filetypes.any").substitute_trailing_whitespace,
		},
	},
})
