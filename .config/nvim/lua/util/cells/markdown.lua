-- Cell detection for jupytext markdown format (ft=markdown).
-- Code cells are fenced code blocks (```lang ... ```).
-- Text sections between code blocks are skipped.

local M = {}

local FENCE_OPEN = "^```%a"
local FENCE_CLOSE = "^```$"

local function line_at(lnum)
  return vim.fn.getline(lnum)
end

function M.current_cell_range()
  local last_line = vim.fn.line("$")
  local open_line = nil

  for lnum = vim.fn.line("."), 1, -1 do
    local current_line = line_at(lnum)
    if current_line:match(FENCE_CLOSE) then return nil end
    if current_line:match(FENCE_OPEN) then open_line = lnum; break end
  end
  if not open_line then return nil end

  for lnum = open_line + 1, last_line do
    if line_at(lnum):match(FENCE_CLOSE) then
      return open_line + 1, lnum - 1
    end
  end
  return nil
end

function M.code_cells_up_to(end_line)
  local result = {}
  local open_line = nil

  for lnum = 1, vim.fn.line("$") do
    local current_line = line_at(lnum)
    if open_line == nil then
      if lnum > end_line then break end
      if current_line:match(FENCE_OPEN) then open_line = lnum end
    elseif current_line:match(FENCE_CLOSE) then
      if open_line + 1 <= lnum - 1 then
        table.insert(result, { open_line + 1, lnum - 1 })
      end
      open_line = nil
    end
  end
  return result
end

return M
