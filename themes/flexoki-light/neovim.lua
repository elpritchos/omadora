return {
  {
    "kepano/flexoki-neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("flexoki").setup({})
      vim.cmd.colorscheme("flexoki-light")
    end,
  },
}
