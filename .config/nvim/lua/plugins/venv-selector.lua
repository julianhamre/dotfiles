local conda_envs = vim.fn.has("mac") == 1
    and "/opt/homebrew/Caskroom/miniconda/base/envs"
    or vim.fn.expand("~/miniconda3/envs")

return {
  "linux-cultist/venv-selector.nvim",
  opts = {
    search = {
      conda_envs = {
        command = "fd '/bin/python$' " .. conda_envs .. " --full-path --color never",
        type = "anaconda",
      },
    },
  },
}
