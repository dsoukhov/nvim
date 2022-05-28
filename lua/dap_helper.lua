local dap = require('dap')

local function attach()
  local ft = vim.bo.filetype
  if(string.lower(ft) == "java")
  then
  else
    local cfg_file = io.open(".dap.json")
    local cfg = cfg_file:read("*a")
    dap.run(vim.fn.json_decode(cfg))
    cfg_file:close()
  end
end

local function cont()
  if dap.session() ~= nil then
    dap.continue()
  else
    attach()
  end
end

local function repl_tog()
  if dap.session() ~= nil then
    dap.repl.toggle({}, ':belowright vsp')
  else
    print("No active session. Doing nothing.")
  end
end

local function step_over_or_load_template()
  if dap.session() ~= nil then
    dap.step_over()
  else
    require('telescope_cfg').task_templates("Build templates", "~/.config/nvim/templates/build", ".tasks")
  end
end

return {
  cont = cont,
  attach = attach,
  repl_tog = repl_tog,
  step_over_or_load_template = step_over_or_load_template
}
