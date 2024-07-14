nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gCc :Git checkout <CR>
nmap <leader>gd :Gdiff <CR>

nmap ]G 9999[g
nmap [G 9999]g

lua << EOF

require('gitsigns').setup {
  signs = {
    add          = {text = '+'},
    change       = {text = '~'},
    delete       = {text = '_'},
    topdelete    = {text = '‾'},
    changedelete = {text = '~'},
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

    map('n', '<leader>gs', gs.stage_hunk)
    map('n', '<leader>gr', gs.reset_hunk)
    map('n', '<leader>gS', gs.stage_buffer)
    map('n', '<leader>gu', gs.undo_stage_hunk)
    map('n', '<leader>gR', gs.reset_buffer)
    map('n', '<leader>gp', gs.preview_hunk)
    map('n', '<leader>gb', function() gs.blame_line{full=true} end)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
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
