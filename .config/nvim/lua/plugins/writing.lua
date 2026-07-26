local GLOBAL_DICT_PATH = vim.fn.stdpath("config") .. "/spell"

return {
  {
    "barreiroleo/ltex_extra.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ltex_plus = {
          filetypes = { "markdown", "text", "tex", "plaintex", "bib", "gitcommit", "quarto", "rmd" },
          on_attach = function(client, _)
            require("ltex_extra").setup({
              load_langs = { "en-US" },
              path = client.config.root_dir or GLOBAL_DICT_PATH,
            })
          end,
          settings = {
            ltex = {
              language = "en-US",
              additionalRules = {
                enablePickyRules = true,
              },
            },
          },
        },
        harper_ls = {
          filetypes = {
            "python", "r", "lua", "rust", "c", "cpp",
            "java", "javascript", "typescript", "go", "sh",
          },
          settings = {
            ["harper-ls"] = {
              userDictPath = GLOBAL_DICT_PATH .. "/harper.txt",
            },
          },
        },
      },
    },
  },
}
