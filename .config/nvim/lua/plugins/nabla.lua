return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "latex" } },
  },
  {
    "jbyuki/nabla.nvim",
    lazy = true,
    keys = {
      {
        "<leader>p",
        function()
          require("nabla").popup()
        end,
        desc = "Nabla: preview equation",
      },
    },
  },
}
