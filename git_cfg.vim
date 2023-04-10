"nmap <leader>gb :Git blame<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gd :Gdiff <CR>
nmap <leader>gCc :Git checkout <CR>

nmap ]G 9999[g
nmap [G 9999]g

lua << EOF

require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']g', function()
      if vim.wo.diff then return ']g' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[g', function()
      if vim.wo.diff then return '[g' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- ['n <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    -- ['v <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    -- ['n <leader>ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    -- ['n <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    -- ['v <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    -- ['n <leader>ghR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    -- ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    -- ['n <leader>gcb'] = '<cmd>lua require"gitsigns".change_base(vim.fn.input("base: "))<CR>',
    -- ['n <leader>gdt'] = '<cmd>lua require"gitsigns".diffthis(vim.fn.input(": "))<CR>',

    -- -- Text objects
    -- ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    -- ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    -- ['o ah'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    -- ['x ah'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
  end,
  watch_gitdir= {
    interval = 1000,
    follow_files = true
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  word_diff = false,
}
EOF
