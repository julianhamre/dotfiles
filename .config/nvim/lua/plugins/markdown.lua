vim.schedule(function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      vim.opt_local.spell = false
    end,
  })
end)

return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = {},
    },
  },
}
