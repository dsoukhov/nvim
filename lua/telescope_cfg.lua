local M = {}
local actions = require('telescope.actions')
local action_set = require('telescope.actions.set')
local action_state = require('telescope.actions.state')
local sorters = require('telescope.sorters')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local utils = require('telescope.utils')

M.project_files = function()
  local retval = pcall(require'telescope.builtin'.git_files)
  if not retval then require'telescope.builtin'.find_files() end
end

M.symbol_doc_lookup = function()
  local ret = pcall(require'telescope.builtin'.lsp_document_symbols)
  if not ret then
    require'telescope.builtin'.treesitter()
  end
end

function M.task_templates(title, path, local_file)
  require('telescope.builtin').find_files {
    prompt_title = title,
    path_display = {'tail'},
    cwd = path,
    attach_mappings = function(prompt_bufnr)
      action_set.select:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_command('e '..local_file)
        vim.api.nvim_command('0r '..path.."/"..entry.value)
      end)
      return true
    end
  }
end

function M.dap_configs()
  local cfg_file = io.open(".dap.json")
  local source
  if cfg_file then
    source = vim.fn.json_decode(cfg_file:read("*a"))
    cfg_file:close()
  else
    print(".dap.json not found")
    return
  end
  local tbl = {}
  local title = "Dap configs"
  for k, _ in pairs(source) do
    table.insert(tbl, k)
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
        require('dap').run(source[entry.value])
      end)
      return true
    end,
  }):find()
end

function M.runner_configs()
  local source = vim.fn['asynctasks#source']("")
  local tbl = {}
  local title = "Task configs"
  for k, v in pairs(source) do
    table.insert(tbl, k, v[1])
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
        vim.api.nvim_command('AsyncTask '..entry.value)
      end)
      return true
    end,
  }):find()
end

function M.git_checkout()
  require('telescope.builtin').git_commits {
  prompt_title = "Git Checkout",
  }
end

function Git_results(selection, action)
  local entry = action_state.get_selected_entry()
  actions.close(selection)
  local project_root = vim.fn.getcwd()
  local cmd = {"git", "log", entry.value, "-n", "1", "--format=format:%H", '--', '.'}
  local results = utils.get_os_command_output(cmd, project_root)[1]
  if results then
    local difffile = "fugitive://"..project_root.."/.git//"..results
    if difffile then
      vim.api.nvim_command(action..difffile)
    end
  end
end

function M.git_log()
  require('telescope.builtin').git_commits {
  prompt_title = "Git Log",
  attach_mappings = function()
    actions.select_default:replace(function(selection)
        Git_results(selection, "split ")
    end)
    actions.select_horizontal:replace(function(selection)
        Git_results(selection, "split ")
    end)
    actions.select_vertical:replace(function(selection)
        Git_results(selection, "vsplit ")
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
        Git_results(selection, "split ")
    end)
    actions.select_horizontal:replace(function(selection)
        Git_results(selection, "split ")
    end)
    actions.select_vertical:replace(function(selection)
        Git_results(selection, "vsplit ")
    end)
    return true
  end
  }
end

function M.sessions_search()
  require('telescope.builtin').find_files {
    prompt_title = "Select Session",
    path_display = {'tail'},
    previewer = false,
    cwd = "~/.local/share/nvim/sessions",
    attach_mappings = function()
      actions.select_default:replace(function(selection)
        local entry = action_state.get_selected_entry()
        actions.close(selection)
        vim.api.nvim_command("SLoad "..entry.value)
      end)
    return true
    end
  }
end

function M.workspace_files()
  require('telescope.builtin').find_files {
    prompt_title = "Workspace",
    cwd = "~/workspace/"
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
