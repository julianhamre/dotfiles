return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ltex_plus = {
        filetypes = { "markdown", "text", "tex", "plaintex", "bib", "gitcommit", "quarto", "rmd" },
        settings = {
          ltex = {
            language = "en-US",
            additionalRules = {
              enablePickyRules = true,
              -- languageModel = vim.fn.expand("~/.local/share/ltex/ngrams/"),  -- if you download n-grams
            },
            dictionary = {
              ["en-US"] = { ":" .. vim.fn.stdpath("config") .. "/spell/ltex.en.txt" },
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
            userDictPath = vim.fn.stdpath("config") .. "/spell/harper.txt",
          },
        },
      },
    },
  },
}
