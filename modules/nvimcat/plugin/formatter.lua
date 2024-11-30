if vim.g.did_load_flash_plugin then
	return
end
vim.g.did_load_flash_plugin = true

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- All formatter configurations are opt-in
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,

			["*"] = {
				-- "formatter.filetypes.any" defines default configurations for any
				-- filetype
				require("formatter.filetypes.any").remove_trailing_whitespace,
				-- Remove trailing whitespace without 'sed'
				-- require("formatter.filetypes.any").substitute_trailing_whitespace,
			},
		},
	},
})
