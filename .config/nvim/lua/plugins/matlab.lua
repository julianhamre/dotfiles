return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        matlab_ls = {
          settings = {
            MATLAB = {
              installPath = "/Applications/MATLAB_R2024b.app", -- e.g. "/Applications/MATLAB_R2025a.app" or "/usr/local/MATLAB/R2024b" — leave "" to auto-detect
              indexWorkspace = true,
              matlabConnectionTiming = "onStart",
              telemetry = false,
            },
          },
        },
      },
    },
  },
  {
    'idossha/matlab.nvim',
    ft = 'matlab',
    config = function()
      require('matlab').setup()
    end
  }
}
