return {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    ft = { "python", "ipynb" },
    init = function()
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
    end,
    config = function()
        local function setup_keymaps(buf)
            local map = function(lhs, rhs, desc, mode)
                vim.keymap.set(mode or "n", lhs, rhs, { buffer = buf, desc = desc })
            end

            -- session
            map("<localleader>I", ":MoltenInit<CR>", "Molten: init kernel")
            map("<localleader>q", ":MoltenInterruptKernel<CR>", "Molten: interrupt kernel")
            map("<localleader>R", ":MoltenRestartKernel<CR>", "Molten: restart kernel")

            -- evaluating (the core loop)
            map("<localleader>l", ":MoltenEvaluateLine<CR>", "Molten: eval line")
            map("<localleader>v", ":<C-u>MoltenEvaluateVisual<CR>", "Molten: eval selection", "v")
            map("<localleader>r", ":MoltenReevaluateCell<CR>", "Molten: re-eval cell")
            map("<localleader>c", function()
                require("util.cells").run_cell()
            end, "Molten: eval cell")
            map("<localleader>f", function()
                require("util.cells").run_all_cells()
            end, "Molten: eval file")
            map("<localleader>a", function()
                require("util.cells").run_cells_above_inclusive()
            end, "Molten: eval cells above (incl. current)")

            -- output
            map("<localleader>o", ":noautocmd MoltenEnterOutput<CR>", "Molten: enter output")
            map("<localleader>h", ":MoltenHideOutput<CR>", "Molten: hide output")
            map("<localleader>i", ":MoltenImagePopup<CR>", "Molten: image popup")
            map("<localleader>d", ":MoltenDelete<CR>", "Molten: delete cell")

            -- navigation
            map("<localleader>n", ":MoltenNext<CR>", "Molten: next cell")
            map("<localleader>p", ":MoltenPrev<CR>", "Molten: prev cell")
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "python", "ipynb" },
            callback = function(event)
                setup_keymaps(event.buf)
            end,
        })

        -- apply to the buffer that triggered the plugin load
        local ft = vim.bo.filetype
        if ft == "python" or ft == "ipynb" then
            setup_keymaps(vim.api.nvim_get_current_buf())
        end
    end,
}
