return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({})
		vim.cmd("colorscheme rose-pine")
	end,
}
