return {
  "ribru17/bamboo.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("bamboo").setup({
      style = "multiplex",
      transparent = true,
    })
    require("bamboo").load()
  end,
}
