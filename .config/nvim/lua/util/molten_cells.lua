-- Cell-boundary helpers for jupytext percent-format files.
-- A cell begins at a "# %%" separator line (or the top of the file)
-- and ends just before the next separator (or at the last line).

local M = {}

-- "# %%" in Lua pattern syntax (each literal % must be escaped as %%)
local SEP = "^# %%%%"

local function is_sep(lnum)
  return vim.fn.getline(lnum):match(SEP) ~= nil
end

-- 1-indexed start line of the cell that contains `lnum`.
local function cell_start(lnum)
  for i = lnum, 1, -1 do
    if is_sep(i) then
      return i
    end
  end
  return 1
end

-- 1-indexed end line of the cell that contains `lnum`.
local function cell_end(lnum)
  local last = vim.fn.line("$")
  for i = lnum + 1, last do
    if is_sep(i) then
      return i - 1
    end
  end
  return last
end

-- Returns (start, end) of the cell under the cursor.
local function current_cell_range()
  local cursor = vim.fn.line(".")
  return cell_start(cursor), cell_end(cursor)
end

-- Evaluate the current cell via molten.
function M.run_cell()
  local s, e = current_cell_range()
  vim.fn.MoltenEvaluateRange(s, e)
end

local function separators_up_to(end_line)
  local seps = {}
  for i = 1, end_line do
    if is_sep(i) and not is_sep(i - 1) then
      table.insert(seps, i)
    end
  end
  if #seps == 0 then
    return { { 1, end_line } }
  end
  return seps
end

local function cells(separators, end_line)
  local cells = {}
  if not is_sep(1) then
    table.insert(cells, { 1, separators[1] - 1 })
  end
  for idx, sep in ipairs(separators) do
    local finish
    if idx < #separators then
      finish = separators[idx + 1] - 1
    else
      finish = end_line
    end
    table.insert(cells, { sep, finish })
  end
  return cells
end

-- Returns a list of {start, end} pairs for every cell from line 1 to `end_line`.
local function cells_up_to(end_line)
  local seps = separators_up_to(end_line)
  local cells = cells(seps, end_line)
  return cells
end

-- Evaluate the given cell ranges,
-- one MoltenEvaluateRange call per cell so each gets its own output window.
local function run_cells(cell_ranges)
  for _, range in ipairs(cell_ranges) do
    vim.fn.MoltenEvaluateRange(range[1], range[2])
  end
end

-- Ensure that the molten kernel is initialized
-- before running the given molten runner function (fn)
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

-- Evaluate from line 1 through the last line of the current cell,
function M.run_cells_above_inclusive()
  molten_run(nil, function()
    local _, e = current_cell_range()
    run_cells(cells_up_to(e))
  end)
end

function M.run_all_cells()
  molten_run(nil, function()
    local end_line = vim.fn.line("$")
    run_cells(cells_up_to(end_line))
  end)
end

return M
