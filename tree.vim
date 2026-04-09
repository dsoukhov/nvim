lua << EOF

require('nvim-treesitter').install({
  "c", "cpp", "cmake", "comment", "go", "java", "javascript",
  "jsx", "lua", "ledger", "markdown", "markdown_inline",
  "python", "rust", "typescript", "tsx", "vim", "vue", "zsh",
  "bash"
})

require('nvim-treesitter-textobjects').setup{
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  }
}

-- Toggle mappings
vim.keymap.set('n', '<leader>tr', function()
  if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil then
    vim.treesitter.stop()
    vim.print("Turned off treesitter highlighting...")
  else
    vim.treesitter.start()
    vim.print("Turned on treesitter highlighting...")
  end
end, { noremap=true, silent=true, desc="Toggle treesitter highlighting" })

vim.keymap.set({ "x", "o" }, "am", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@function.outer", "textobjects")
end, { desc = "Function outer region" })
vim.keymap.set({ "x", "o" }, "im", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@function.inner", "textobjects")
end, { desc = "Function inner region" })

vim.keymap.set({ "x", "o" }, "ac", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@class.outer", "textobjects")
end, { desc = "Class outer region" })
vim.keymap.set({ "x", "o" }, "ic", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@class.inner", "textobjects")
end, { desc = "Class inner region" })

vim.keymap.set({ "x", "o" }, "ab", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@block.outer", "textobjects")
end, { desc = "Block outer region" })
vim.keymap.set({ "x", "o" }, "ib", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@block.inner", "textobjects")
end, { desc = "Block inner region" })

vim.keymap.set({ "n", "x", "o" }, "]m", function()
  require('nvim-treesitter-textobjects.move').goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function" })
vim.keymap.set({ "n", "x", "o" }, "]M", function()
  require('nvim-treesitter-textobjects.move').goto_next_end("@function.outer", "textobjects")
end, { desc = "End of next function" })
vim.keymap.set({ "n", "x", "o" }, "[m", function()
  require('nvim-treesitter-textobjects.move').goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function" })
vim.keymap.set({ "n", "x", "o" }, "[M", function()
  require('nvim-treesitter-textobjects.move').goto_previous_end("@function.outer", "textobjects")
end, { desc = "End of previous function" })

vim.keymap.set({ "n", "x", "o" }, "]c", function()
  require('nvim-treesitter-textobjects.move').goto_next_start("@class.outer", "textobjects")
end, { desc = "Next class" })
vim.keymap.set({ "n", "x", "o" }, "]C", function()
  require('nvim-treesitter-textobjects.move').goto_next_end("@class.outer", "textobjects")
end, { desc = "End of next class" })
vim.keymap.set({ "n", "x", "o" }, "[c", function()
  require('nvim-treesitter-textobjects.move').goto_previous_start("@class.outer", "textobjects")
end, { desc = "Previous class" })
vim.keymap.set({ "n", "x", "o" }, "[C", function()
  require('nvim-treesitter-textobjects.move').goto_previous_end("@class.outer", "textobjects")
end, { desc = "End of previous class" })

vim.keymap.set({ "n", "x", "o" }, "]b", function()
  require('nvim-treesitter-textobjects.move').goto_next_start("@block.outer", "textobjects")
end, { desc = "Next block" })
vim.keymap.set({ "n", "x", "o" }, "]B", function()
  require('nvim-treesitter-textobjects.move').goto_next_end("@block.outer", "textobjects")
end, { desc = "End of next block" })
vim.keymap.set({ "n", "x", "o" }, "[b", function()
  require('nvim-treesitter-textobjects.move').goto_previous_start("@block.outer", "textobjects")
end, { desc = "Previous block" })
vim.keymap.set({ "n", "x", "o" }, "[B", function()
  require('nvim-treesitter-textobjects.move').goto_previous_end("@block.outer", "textobjects")
end, { desc = "End of previous block" })

require('ts_context_commentstring').setup {}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require'nvim-tree'.setup {
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
  side = 'left',
    -- if true the tree will resize itself after opening a file
  },
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
}

vim.g.nvim_tree_show_icons = {
  git = 1,
  files = 1,
  folders = 1,
}
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★"
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  },
}
require'nvim-rooter'.setup()

require("ibl").setup {
  indent = { char = '┊' },
  scope = { highlight = highlight }
}
require("notify").setup({
  render = "minimal",
  stages = "static",
  timeout = 2000
})

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
})

EOF

"nvim-tree cfg
let g:nvim_tree_respect_buf_cwd = 1
nnoremap <silent> <leader>n :NvimTreeToggle<CR>
