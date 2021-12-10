lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  context_commentstring = {
    enable = true
  },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim 
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      }
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]b"] = "@block.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]B"] = "@block.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[b"] = "@block.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[B"] = "@block.outer",
      },
    },
  }
}

vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_context_patterns = {
  "abstract_class_declaration", "abstract_method_signature",
  "accessibility_modifier", "ambient_declaration", "arguments", "array",
  "array_pattern", "array_type", "arrow_function", "as_expression",
  "asserts", "assignment_expression", "assignment_pattern",
  "augmented_assignment_expression", "await_expression",
  "binary_expression", "break_statement", "call_expression",
  "call_signature", "catch_clause", "class", "class_body",
  "class_declaration", "class_heritage", "computed_property_name",
  "conditional_type", "constraint", "construct_signature",
  "constructor_type", "continue_statement", "debugger_statement",
  "declaration", "decorator", "default_type", "do_statement",
  "else_clause", "empty_statement", "enum_assignment", "enum_body",
  "enum_declaration", "existential_type", "export_clause",
  "export_specifier", "export_statement", "expression",
  "expression_statement", "extends_clause", "finally_clause",
  "flow_maybe_type", "for_in_statement", "for_statement",
  "formal_parameters", "function", "function_declaration",
  "function_signature", "function_type", "generator_function",
  "generator_function_declaration", "generic_type", "if_statement",
  "implements_clause", "import", "import_alias", "import_clause",
  "import_require_clause", "import_specifier", "import_statement",
  "index_signature", "index_type_query", "infer_type",
  "interface_declaration", "internal_module", "intersection_type",
  "jsx_attribute", "jsx_closing_element", "jsx_element", "jsx_expression",
  "jsx_fragment", "jsx_namespace_name", "jsx_opening_element",
  "jsx_self_closing_element", "labeled_statement", "lexical_declaration",
  "literal_type", "lookup_type", "mapped_type_clause",
  "member_expression", "meta_property", "method_definition",
  "method_signature", "module", "named_imports", "namespace_import",
  "nested_identifier", "nested_type_identifier", "new_expression",
  "non_null_expression", "omitting_type_annotation",
  "opting_type_annotation", "optional_parameter", "optional_type", "pair",
  "pair_pattern", "parenthesized_expression", "parenthesized_type",
  "pattern", "predefined_type", "primary_expression", "program",
  "property_signature", "public_field_definition", "readonly_type",
  "regex", "required_parameter", "rest_pattern", "rest_type",
  "return_statement", "sequence_expression", "spread_element",
  "statement", "statement_block", "string", "subscript_expression",
  "switch_body", "switch_case", "switch_default", "switch_statement",
  "template_string", "template_substitution", "ternary_expression",
  "throw_statement", "try_statement", "tuple_type",
  "type_alias_declaration", "type_annotation", "type_arguments",
  "type_parameter", "type_parameters", "type_predicate",
  "type_predicate_annotation", "type_query", "unary_expression",
  "union_type", "update_expression", "variable_declaration",
  "variable_declarator", "while_statement", "with_statement",
  "yield_expression", 'class', 'function', 'method', '^if',
  '^while', '^for', '^object', '^table', 'block', 'comment'
}

require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = { 'startify', 'dashboard' },
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close          = false,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir   = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = false,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = true,
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = true,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
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
EOF

highlight IndentBlanklineContextChar guifg=#EBA217 gui=nocombine
nmap <Leader>tr :write \| edit \| TSBufEnable highlight<CR>
"let g:indent_blankline_char="│"
let g:indent_blankline_char = '┊'

let g:rooter_silent_chdir = 1

"nvim-tree cfg
let g:nvim_tree_respect_buf_cwd = 1
nnoremap <leader>n :NvimTreeToggle<CR>
