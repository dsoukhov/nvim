local M = {}
local actions = require('telescope.actions')
local action_set = require('telescope.actions.set')
local action_state = require('telescope.actions.state')
local sorters = require('telescope.sorters')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local utils = require('telescope.utils')

M.project_files = function()
  local _, retval = pcall(require'telescope.builtin'.git_files)
  if not retval then require'telescope.builtin'.find_files() end
end

M.symbol_doc_lookup = function()
  local _, retval = pcall(require'telescope.builtin'.lsp_document_symbols)
  if not retval then require'telescope.builtin'.treesitter() end
end

function M.dap_templates()
  require('telescope.builtin').find_files {
    prompt_title = "Dap templates",
    shorten_path = false,
    cwd = "~/.config/nvim/dap-json",
    attach_mappings = function(prompt_bufnr)
      action_set.select:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_command('e .dap.json')
        vim.api.nvim_command('0r ~/.config/nvim/dap-json/'..entry.value)
      end)
      return true
    end
  }
end

function M.yanks(aftercursor)
  local source = vim.fn['miniyank#read']()
  local tbl = {}
  local title = "yanks"
  if aftercursor then
    title = "Yanks"
  end
  for k, v in pairs(source) do
    table.insert(tbl, k, v[1][1])
  end
  pickers.new({
    prompt_title = title,
    finder = finders.new_table {
      results = tbl,
      entry_maker = function(line)
      if line == "" then
        return nil
      end
      return {
        value = line,
        ordinal = line,
        display = line
      }
      end
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(selected)
      action_set.select:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(selected)
        vim.api.nvim_put({entry.value}, "", aftercursor, true)
      end)
      return true
    end,
  }):find()
end

function M.debugger_templates()
  require('telescope.builtin').find_files {
    prompt_title = "Debugger templates",
    shorten_path = true,
    cwd = "~/.config/nvim/debugger/templates",
    attach_mappings = function(prompt_bufnr)
      action_set.select:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_command('e .debug.json')
        vim.api.nvim_command('0r ~/.config/nvim/debugger/templates/'..entry.value)
      end)
      return true
    end
  }
end

function M.runner_templates()
  require('telescope.builtin').find_files {
    prompt_title = "Runner templates",
    shorten_path = true,
    cwd = "~/.config/nvim/async-tasks/templates",
    attach_mappings = function(prompt_bufnr)
      action_set.select:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_command('e .tasks')
        vim.api.nvim_command('0r ~/.config/nvim/async-tasks/templates/'..entry.value)
      end)
      return true
    end
  }
end

function M.git_log()
  require('telescope.builtin').git_commits {
  prompt_title = "Git Log",
  attach_mappings = function()
    actions.select_default:replace(function(selection)
      local entry = action_state.get_selected_entry()
      actions.close(selection)
      local project_root = vim.fn.getcwd()
      local cmd = {"git", "log", entry.value, "-n", "1", "--format=format:%H", '--', '.'}
      local results = utils.get_os_command_output(cmd, project_root)[1]
      if results then
        local difffile = "fugitive://"..project_root.."/.git//"..results
        vim.api.nvim_command("e "..difffile)
      end
    end)
    return true
  end
  }
end

function M.git_cbuf()
  require('telescope.builtin').git_bcommits {
  prompt_title = "Git buffer commits",
  attach_mappings = function()
    actions.select_default:replace(function(selection)
      local entry = action_state.get_selected_entry()
      actions.close(selection)
      local project_root = vim.fn.getcwd()
      local cmd = {"git", "log", entry.value, "-n", "1", "--format=format:%H", '--', '.'}
      local results = utils.get_os_command_output(cmd, project_root)[1]
      if results then
        local difffile = "fugitive://"..project_root.."/.git//"..results
        vim.api.nvim_command("e "..difffile)
      end
    end)
    return true
  end
  }
end

function M.workspace_files()
  require('telescope.builtin').find_files {
    prompt_title = "Workspace",
    shorten_path = false,
    cwd = "~/workspace/"
  }
end

function M.config_files()
  require('telescope.builtin').find_files {
    prompt_title = "Config",
    shorten_path = false,
    cwd = "~/.config/"
  }
end

function M.fuz_buf()
  require('telescope.builtin').live_grep {
    prompt_title = "Open files search",
    grep_open_files	= true
}
end

function M.search_all_files()
  require("telescope.builtin").find_files {
    find_command = { "rg", "--files", "-g", "!node_modules/**"},
    grep_open_files	= false
  }
end

function M.search_only_certain_files()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input "Type: ",
      "-g", "!node_modules/**"
    },
  }
end

return M
