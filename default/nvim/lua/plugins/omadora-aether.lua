return {
  {
    'elpritchos/aether.nvim',
    branch = 'v3',
    priority = 1000,
    config = function()
      require('aether').setup()
      vim.cmd.colorscheme 'aether'
    end,
  },
}
