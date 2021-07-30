local M = {}
local actions = require('telescope.actions')
local action_set = require('telescope.actions.set')
local action_state = require('telescope.actions.state')
local sorters = require('telescope.sorters')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local utils = require('telescope.utils')

function _GetClipmenuList()
  local cmd = {"bash", "-c", "LC_ALL=C sort -rnk1 /home/daniel/.cache/clipmenu.6.daniel/line_cache | cut -d' ' -f2- | awk '!seen[$0]++'"}
  local list = utils.get_os_command_output(cmd)
  return list
end

--properly escape all lua special chars
function _StringCleanup(str)
  str = str:gsub("\\", "\\\\")
  str = str:gsub("\"", "\\\"")
  return str
end

function _GetClipmenuEntry(chosen_line, clipboardPaste, delim)
  delim = delim or "\'"
  local cmd = {"bash", "-c", string.format("cksum <<< %s%s%s", delim, chosen_line, delim)}
  local chksum = utils.get_os_command_output(cmd)
  if chksum[1] == nil and delim == "'" then
    return _GetClipmenuEntry(chosen_line, clipboardPaste, "\"")
  end
  local clipmenuEntryFile =  "'/home/daniel/.cache/clipmenu.6.daniel/"..chksum[1].."'"
  local to_paste = utils.get_os_command_output({"bash", "-c", "cat "..clipmenuEntryFile})
  if to_paste[1] == nil and delim == "\'" then
    to_paste = _GetClipmenuEntry(chosen_line, clipboardPaste, "\"")
  end
  if clipboardPaste then
    utils.get_os_command_output({"bash", "-c", "xsel --logfile /dev/null -i --clipboard < "..clipmenuEntryFile})
  end
  return to_paste
end

function _Clipmenu_yankring_cycle(dir)
  local curpos = vim.g.clipmenu_pos
  local list = _GetClipmenuList()
  local prevlist  = vim.g.clipmenu_list
  if curpos == nil or prevlist == nil or prevlist[1] ~= list[1] then
    vim.api.nvim_set_var("clipmenu_list", list)
    curpos = 1
  end
  curpos = (curpos + dir) % #list
  if curpos == 0 then
    curpos = #list
  end
  local to_paste = _GetClipmenuEntry(list[curpos])
  vim.api.nvim_set_var("clipmenu_pos", curpos)
  local prev_paste_sel = vim.fn.strpart(vim.fn.getregtype(), 0 , 1)
  local prev_paste_mark  = vim.api.nvim_buf_get_mark(0, "]")
  if prev_paste_mark[1] <= vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].botline then
    vim.cmd("normal "..'`[' .. prev_paste_sel .. '`]' .. "\"_d")
    --vim.cmd("normal gp \"_d")
    vim.api.nvim_put(to_paste, "", false, true)
  end
end

function _Clipmenu_telescope(aftercursor)
  local title = "yanks"
  if aftercursor then
    title = "Yanks"
  end
  pickers.new({
    prompt_title = title,
    finder = finders.new_table {
      results = _GetClipmenuList(),
      entry_maker = function(line)
        if line == nil then
          return ""
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
        local chosen_line = _StringCleanup(action_state.get_selected_entry().value)
        local result = _GetClipmenuEntry(chosen_line, true)
        actions.close(selected)
        vim.api.nvim_put(result, "", aftercursor, true)
      end)
      return true
    end,
  }):find()
end

function M.setup()
end

function M.clipmenu_yankring_cycle_back()
  _Clipmenu_yankring_cycle(-1)
end

function M.clipmenu_yankring_cycle_forward()
  _Clipmenu_yankring_cycle(1)
end

function M.clipmenu_telescope_AC()
  _Clipmenu_telescope(true)
end

function M.clipmenu_telescope_BC()
  _Clipmenu_telescope(false)
end

return M
