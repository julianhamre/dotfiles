local M = {}

local function cells()
  if vim.bo.filetype == "markdown" then
    return require("util.cells.markdown")
  else
    return require("util.cells.percent")
  end
end

local function molten_run(kernel, fn)
  local ok, kernels = pcall(vim.fn.MoltenRunningKernels, true)
  if ok and kernels and #kernels > 0 then
    fn()
    return
  end

  local autocmd_id
  autocmd_id = vim.api.nvim_create_autocmd("User", {
    pattern = "MoltenKernelReady",
    callback = function(e)
      if kernel and e.data and e.data.kernel_id ~= kernel then
        return
      end
      vim.api.nvim_del_autocmd(autocmd_id)
      fn()
    end,
  })

  vim.cmd(kernel and ("MoltenInit " .. kernel) or "MoltenInit")
end

function M.run_cell()
  local s, e = cells().current_cell_range()
  if s then vim.fn.MoltenEvaluateRange(s, e) end
end

local function run_cells(cell_ranges)
  for _, range in ipairs(cell_ranges) do
    vim.fn.MoltenEvaluateRange(range[1], range[2])
  end
end

function M.run_cells_above_inclusive()
  molten_run(nil, function()
    local _, e = cells().current_cell_range()
    run_cells(cells().code_cells_up_to(e))
  end)
end

function M.run_all_cells()
  molten_run(nil, function()
    local end_line = vim.fn.line("$")
    run_cells(cells().code_cells_up_to(end_line))
  end)
end

return M
