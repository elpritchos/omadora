return {
  {
    "bjarneo/vantablack.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("vantablack")
    end,
  },
}
