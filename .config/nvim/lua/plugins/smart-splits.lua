return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    require("smart-splits").setup()
    local ss = require("smart-splits")
    vim.keymap.set({ "n", "v", "t" }, "<C-h>", ss.move_cursor_left, { desc = "Move to left pane" })
    vim.keymap.set({ "n", "v", "t" }, "<C-j>", ss.move_cursor_down, { desc = "Move to lower pane" })
    vim.keymap.set({ "n", "v", "t" }, "<C-k>", ss.move_cursor_up, { desc = "Move to upper pane" })
    vim.keymap.set({ "n", "v", "t" }, "<C-l>", ss.move_cursor_right, { desc = "Move to right pane" })
    vim.keymap.set({ "n", "v" }, "<C-Left>", ss.resize_left, { desc = "Resize pane left" })
    vim.keymap.set({ "n", "v" }, "<C-Down>", ss.resize_down, { desc = "Resize pane down" })
    vim.keymap.set({ "n", "v" }, "<C-Up>", ss.resize_up, { desc = "Resize pane up" })
    vim.keymap.set({ "n", "v" }, "<C-Right>", ss.resize_right, { desc = "Resize pane right" })
  end,
}
