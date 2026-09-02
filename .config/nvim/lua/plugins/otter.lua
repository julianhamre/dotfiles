return {
  "jmbuhr/otter.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "markdown" },
  config = function()
    require("otter").setup({})
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.schedule(function()
          require("otter").activate()
        end)
      end,
    })
  end,
  keys = {
    { "<leader>oa", function() require("otter").activate() end, desc = "Otter: activate" },
    { "<leader>od", function() require("otter").deactivate() end, desc = "Otter: deactivate" },
  },
}
