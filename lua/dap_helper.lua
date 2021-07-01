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

return {
  cont = cont,
  attach = attach
}
