local M = {}
local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")
local sorters = require("telescope.sorters")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local utils = require("telescope.utils")

function _GetClipmenuList()
	local cmd = {
		"sh",
		"-c",
		string.format(
			"LC_ALL=C sort -rnk1 %s/line_cache | cut -d' ' -f2- | awk '!seen[$0]++'",
			vim.api.nvim_get_var("clipmenu_cache_dir")
		),
	}
	local list = utils.get_os_command_output(cmd)
	return list
end

--escape lua special chars for use in external bash commands
function _StringCleanup(str)
	str = str:gsub("\\", "\\\\")
	str = str:gsub('"', '\\"')
	str = str:gsub("`", "\\`")
	return str
end

function _GetClipmenuEntry(chosen_line, copyToClip, delim)
	delim = delim or "'"
	local cmd = { "bash", "-c", string.format("cksum <<< %s%s%s", delim, chosen_line, delim) }
	local chksum = utils.get_os_command_output(cmd)
	if chksum[1] == nil and delim == "'" then
		return _GetClipmenuEntry(chosen_line, copyToClip, '"')
	end
	local clipmenuEntryFile = string.format("'%s/%s'", vim.api.nvim_get_var("clipmenu_cache_dir"), chksum[1])
	local to_paste = utils.get_os_command_output({ "sh", "-c", "cat " .. clipmenuEntryFile })
	if to_paste[1] == nil and delim == "'" then
		return _GetClipmenuEntry(chosen_line, copyToClip, '"')
	end
	if copyToClip then
		utils.get_os_command_output({ "sh", "-c", "xsel --logfile /dev/null -i --clipboard < " .. clipmenuEntryFile })
	end
	return to_paste
end

function _ClipmenuYankringCycle(direction)
	local curpos = vim.g.clipmenu_pos
	local prevlines = vim.g.clipmenu_cache_lines
  local enteries = _GetClipmenuList()
	if curpos == nil or prevlines == nil or prevlines ~= #enteries then
		print("New entry found. Resetting yankring position.")
		vim.api.nvim_set_var("clipmenu_cache_lines", #enteries)
		curpos = 1
	else
		curpos = (curpos + direction) % #enteries
		if curpos == 0 then
			curpos = #enteries
		end
	end
	vim.api.nvim_set_var("clipmenu_pos", curpos)
	local to_paste = _GetClipmenuEntry(_StringCleanup(enteries[curpos]), false)
	local prev_paste_sel = vim.fn.strpart(vim.fn.getregtype(), 0, 1)
	local prev_paste_mark_end = vim.api.nvim_buf_get_mark(0, "]")
	if prev_paste_mark_end[1] <= vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].botline then
		vim.cmd("normal " .. "`[" .. prev_paste_sel .. "`] \"_c")
		vim.api.nvim_put(to_paste, "", true, true)
	else
		print("Previous paste not found.")
	end
end

function _ClipmenuTelescope(aftercursor, isVisual)
	local title = "yanks"
	if aftercursor then
		title = "Yanks"
	end
	pickers.new({
		prompt_title = title,
		finder = finders.new_table({
			results = _GetClipmenuList(),
			entry_maker = function(line)
				return {
					value = line,
					ordinal = line,
					display = line,
				}
			end,
		}),
		sorter = sorters.get_generic_fuzzy_sorter(),
		attach_mappings = function(selected)
			action_set.select:replace(function()
				local chosen_line = _StringCleanup(action_state.get_selected_entry().value)
				local result = _GetClipmenuEntry(chosen_line, true)
				actions.close(selected)
				if isVisual then
					vim.cmd("normal gv \"_c")
				end
				vim.api.nvim_put(result, "", aftercursor, true)
			end)
			return true
		end,
	}):find()
end

function M.setup(config)
	vim.api.nvim_set_var("clipmenu_cache_dir", config.cache_dir)
end

function M.clipmenu_yankring_cycle_back()
	_ClipmenuYankringCycle(-1)
end

function M.clipmenu_yankring_cycle_forward()
	_ClipmenuYankringCycle(1)
end

function M.clipmenu_telescope_VM()
	_ClipmenuTelescope(true, true)
end

function M.clipmenu_telescope_AC()
	_ClipmenuTelescope(true)
end

function M.clipmenu_telescope_BC()
	_ClipmenuTelescope(false)
end

return M
