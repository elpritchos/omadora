return {
	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("rose-pine-dawn")
		end,
	},
}
