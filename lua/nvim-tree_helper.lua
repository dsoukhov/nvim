local tree ={}

tree.open = function ()
   require'bufferline.state'.set_offset(31)
   require'nvim-tree'.find_file(true)
end

tree.close = function ()
   require'bufferline.state'.set_offset(0)
   require'nvim-tree'.close()
end

tree.toggle = function()
   if require'nvim-tree.view'.win_open() then
     tree.close()
   else
     tree.open()
   end
end

return tree
