return {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
        -- these are examples, not defaults. Please see the readme
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
    end,
    keys = {
        -- session
        { "<leader>mi", ":MoltenInit<CR>", desc = "Molten: init kernel" },
        { "<leader>mq", ":MoltenInterruptKernel<CR>", desc = "Molten: interrupt kernel" },
        { "<leader>mR", ":MoltenRestartKernel<CR>", desc = "Molten: restart kernel" },

        -- evaluating (the core loop)
        { "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "Molten: eval line" },
        { "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>", mode = "v", desc = "Molten: eval selection" },
        { "<leader>mr", ":MoltenReevaluateCell<CR>", desc = "Molten: re-eval cell" },
        { "<leader>mf", function()
            vim.cmd("normal! ggVG")
            vim.cmd("MoltenEvaluateVisual")
          end, desc = "Molten: eval file" },
        { "<leader>ma", function()
            local line = vim.fn.line(".")
            vim.cmd("normal! ggV" .. line .. "G")
            vim.cmd("MoltenEvaluateVisual")
          end, desc = "Molten: eval top to cursor" },

        -- output
        { "<leader>mo", ":noautocmd MoltenEnterOutput<CR>", desc = "Molten: enter output" },
        { "<leader>mh", ":MoltenHideOutput<CR>", desc = "Molten: hide output" },
        { "<leader>mI", ":MoltenImagePopup<CR>", desc = "Molten: image popup" },
        { "<leader>md", ":MoltenDelete<CR>", desc = "Molten: delete cell" },

        -- navigation
        { "<leader>mn", ":MoltenNext<CR>", desc = "Molten: next cell" },
        { "<leader>mp", ":MoltenPrev<CR>", desc = "Molten: prev cell" },
    },
}
