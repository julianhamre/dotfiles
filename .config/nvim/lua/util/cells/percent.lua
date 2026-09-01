-- Cell detection for jupytext percent format (ft=python).
-- Cells are delimited by "# %%" separator lines.

local M = {}

local SEP = "^# %%%%"
local MARKDOWN_SEP = "^# %%%% %[markdown%]"

local function is_sep(lnum)
  return vim.fn.getline(lnum):match(SEP) ~= nil
end

local function is_markdown_cell(start_line)
  return vim.fn.getline(start_line):match(MARKDOWN_SEP) ~= nil
end

local function cell_start(lnum)
  for i = lnum, 1, -1 do
    if is_sep(i) then return i end
  end
  return 1
end

local function cell_end(lnum)
  local last = vim.fn.line("$")
  for i = lnum + 1, last do
    if is_sep(i) then return i - 1 end
  end
  return last
end

function M.current_cell_range()
  local cursor = vim.fn.line(".")
  local s = cell_start(cursor)
  if is_markdown_cell(s) then return nil end
  return s, cell_end(cursor)
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

function M.code_cells_up_to(end_line)
  local seps = separators_up_to(end_line)
  local cells = cells(seps, end_line)
  return cells
end

return M
