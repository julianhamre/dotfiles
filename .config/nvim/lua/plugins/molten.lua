return {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
        require("which-key").add({ { "<leader>m", group = "molten", icon = "⚗️" } })
    end,
    keys = {
        -- session
        { "<leader>mI", ":MoltenInit<CR>", desc = "Molten: init kernel" },
        { "<leader>mq", ":MoltenInterruptKernel<CR>", desc = "Molten: interrupt kernel" },
        { "<leader>mR", ":MoltenRestartKernel<CR>", desc = "Molten: restart kernel" },

        -- evaluating (the core loop)
        { "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "Molten: eval line" },
        { "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>", mode = "v", desc = "Molten: eval selection" },
        { "<leader>mr", ":MoltenReevaluateCell<CR>", desc = "Molten: re-eval cell" },
        { "<leader>mf", function()
            vim.fn.MoltenEvaluateRange(1, vim.fn.line("$"))
          end, desc = "Molten: eval file" },
        { "<leader>ma", function()
            vim.fn.MoltenEvaluateRange(1, vim.fn.line("."))
          end, desc = "Molten: eval top to cursor" },

        -- output
        { "<leader>mo", ":noautocmd MoltenEnterOutput<CR>", desc = "Molten: enter output" },
        { "<leader>mh", ":MoltenHideOutput<CR>", desc = "Molten: hide output" },
        { "<leader>mi", ":MoltenImagePopup<CR>", desc = "Molten: image popup" },
        { "<leader>md", ":MoltenDelete<CR>", desc = "Molten: delete cell" },

        -- navigation
        { "<leader>mn", ":MoltenNext<CR>", desc = "Molten: next cell" },
        { "<leader>mp", ":MoltenPrev<CR>", desc = "Molten: prev cell" },
    },
}
