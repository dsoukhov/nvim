local dap = require('dap')

local function attach()
  local cfg_file = io.open(".dap.json")
  if cfg_file then
    local cfg = vim.fn.json_decode(cfg_file:read("*a"))
    if cfg["default"] then
      dap.run(cfg["default"])
    else
      print("default dap cfg not found")
      require('telescope_cfg').dap_configs()
    end
    cfg_file:close()
  else
    print(".dap.json not found")
  end
end

local function cont()
  if dap.session() ~= nil then
    dap.continue()
  else
    attach()
  end
end

local function reverse_continue_or_run_dap_templates()
  if dap.session() ~= nil then
    dap.reverse_continue()
  else
    require('telescope_cfg').dap_configs()
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
  step_over_or_load_template = step_over_or_load_template,
  reverse_continue_or_run_dap_templates = reverse_continue_or_run_dap_templates
}
