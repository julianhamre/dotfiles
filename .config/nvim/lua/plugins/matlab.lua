return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        matlab_ls = {
          settings = {
            MATLAB = {
              installPath = "/Applications/MATLAB_R2026a.app",
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
