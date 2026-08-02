local M = {}

local runner_pane = nil

-- Values can be a string prefix or a function(filepath) -> string.
local runners = {
  python = function(filepath)
    local ok, venv = pcall(require, "venv-selector")
    local python = (ok and venv.python()) or "python3"
    return python .. " " .. vim.fn.shellescape(filepath)
  end,
  sh         = "bash",
  bash       = "bash",
  javascript = "node",
  lua        = "lua",
  java = function(filepath)
    local pom = vim.fn.findfile("pom.xml", vim.fn.fnamemodify(filepath, ":h") .. ";")
    local dir = vim.fn.fnamemodify(pom ~= "" and pom or filepath, ":h")
    return "cd " .. vim.fn.shellescape(dir) .. " && mvn compile exec:java"
  end,
}

local function pane_exists(pane_id)
  if not pane_id then return false end
  local panes = vim.fn.system('tmux list-panes -a -F "#{pane_id}"')
  return panes:find(pane_id, 1, true) ~= nil
end

local function run_in_tmux(cmd)
  local is_new = not pane_exists(runner_pane)
  if is_new then
    local result = vim.fn.system("tmux split-window -vd -l 10 -PF '#{pane_id}' zsh -i")
    runner_pane = vim.trim(result)
  end
  local target = vim.fn.shellescape(runner_pane)
  if not is_new then
    vim.fn.system("tmux send-keys -t " .. target .. " C-c")
  end
  vim.fn.system("tmux send-keys -t " .. target .. " " .. vim.fn.shellescape(cmd) .. " Enter")
end

function M.run()
  local ft = vim.bo.filetype
  local runner = runners[ft]
  if not runner then
    vim.notify("No runner for filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  local filepath = vim.fn.expand("%:p")
  if filepath == "" then
    vim.notify("Buffer has no file", vim.log.levels.WARN)
    return
  end

  if vim.bo.modified then vim.cmd("write") end

  local cmd = type(runner) == "function" and runner(filepath) or (runner .. " " .. vim.fn.shellescape(filepath))
  run_in_tmux(cmd)
end

return M
