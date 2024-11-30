return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- add tsx and treesitter
			vim.list_extend(opts.ensure_installed, {
				"python",
				"c",
				"astro",
				"cpp",
				"tsx",
				"typescript",
			})
		end,
	},
}
