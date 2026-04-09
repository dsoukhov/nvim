lua << EOF
-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--   ignore_install = { "cpp" }, -- List of parsers to ignore installing
--   auto_install = true,
--   highlight = {
--     enable = true,              -- false will disable the whole extension
--     disable = {},  -- list of language that will be disabled
--   },
--   indent = {
--     enable = true
--   },
--   autotag = {
--     enable = true
--   },
--   textobjects = {
--     select = {
--       enable = true,

--       -- Automatically jump forward to textobj, similar to targets.vim 
--       lookahead = true,

--       keymaps = {
--         -- You can use the capture groups defined in textobjects.scm
--         ["af"] = "@function.outer",
--         ["if"] = "@function.inner",
--         ["ac"] = "@class.outer",
--         ["ic"] = "@class.inner",
--         ["ab"] = "@block.outer",
--         ["ib"] = "@block.inner",
--       }
--     },
--     move = {
--       enable = true,
--       set_jumps = true, -- whether to set jumps in the jumplist
--       goto_next_start = {
--         ["]m"] = "@function.outer",
--         ["]c"] = "@class.outer",
--         ["]b"] = "@block.outer",
--       },
--       goto_next_end = {
--         ["]M"] = "@function.outer",
--         ["]C"] = "@class.outer",
--         ["]B"] = "@block.outer",
--       },
--       goto_previous_start = {
--         ["[m"] = "@function.outer",
--         ["[c"] = "@class.outer",
--         ["[b"] = "@block.outer",
--       },
--       goto_previous_end = {
--         ["[M"] = "@function.outer",
--         ["[C"] = "@class.outer",
--         ["[B"] = "@block.outer",
--       },
--     },
--   }
-- }

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
    folders = 1,
    files = 1,
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
require("nvim-navic").setup{
  lsp = {
      auto_attach = true
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
