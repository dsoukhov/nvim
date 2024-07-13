lua << EOF

-- fix https://github.com/neovim/neovim/issues/21856
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.fn.jobstart("", { detach = true })
  end,
})

-- line diag config
vim.diagnostic.config({
  virtual_text = false, -- Turn off inline diagnostics
  float = {
    focusable = false,
    style = "minimal",
    source = "always",
    header = "",
    prefix = "",
  },
})

 -- Use this if you want it to automatically show all diagnostics on the
 -- current line in a floating window.
vim.cmd('autocmd CursorHold * lua vim.diagnostic.open_float()')
vim.o.updatetime = 200

-- Setup nvim-cmp.
vim.o.completeopt = "menu,menuone,noselect"

local cmp = require'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  formatting = {
    fields = { "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        vsnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'nvim_lsp', max_item_count = 10 },
    { name = 'buffer', max_item_count = 5 },
    { name = "vsnip", max_item_count = 5},
    { name = 'path', max_item_count = 5 },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'gdt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', 'H', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>Telescope diagnostics<CR>', opts)
  --buf_set_keymap('n', '=d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  --buf_set_keymap('n', '<space>l', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- require "lsp_signature".on_attach({
  --   bind = true, -- This is mandatory, otherwise border config won't get registered.
  --   hint_prefix = "",
  --   handler_opts = {
  --     border = "single",
  --     floating_window_above_cur_line = true
  --   },
  -- })
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
      vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
      vim.api.nvim_create_autocmd("CursorHold", {
          callback = vim.lsp.buf.document_highlight,
          buffer = bufnr,
          group = "lsp_document_highlight",
          desc = "Document Highlight",
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
          callback = vim.lsp.buf.clear_references,
          buffer = bufnr,
          group = "lsp_document_highlight",
          desc = "Clear All the References",
      })
  end
end

local function make_config()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
return {
    capabilities = capabilities,
    on_attach = on_attach
  }
end

local clangd_settings = {
  clangd = {
    filetypes = { "c", "cpp" },
    rootPatterns = { "compile_commands.json", ".git", "Makefile" },
    args = {
      -- "-j=6",
      -- "--limit-results=0",
      -- "--cross-file-rename",
      -- "--compile_args_from=filesystem",
      -- "--all-scopes-completion",
      -- "--background-index",
      ----https://clangd.llvm.org/config.html
      ----set project config in .clangd at root
      -- "--enable-config",
      -- "--completion-parse=always",
      -- "--completion-style=detailed",
      -- "--function-arg-placeholders",
      -- "--header-insertion-decorators",
      -- "--header-insertion=never",
    },
  }
}

local lua_settings = {
  Lua = {
    runtime = {
      version = "LuaJIT"
    },

    diagnostics = {
      enable = true,
      globals = vim.list_extend({
          -- Neovim
          "vim",
          -- others
          "describe", "it", "before_each", "after_each", "teardown", "pending", "clear",
        }, {}
      ),
    },
    telemetry = {
      enable = false,
    },
    workspace = {
      maxPreload = 5000,
      preloadFileSize = 5000,
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        [vim.fn.expand('~/.config/nvim/plugged')] = true,
      },
    },
  }
}

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
  function(server)
    local opts = make_config()
    -- (optional) Customize the options passed to the server
    if server == "clangd" then
      opts.settings=clangd_settings
    end
    if server == "lua_ls" then
      opts.settings=lua_settings
    end
    if server == "jdtls" then
      opts.use_lombok_agent = true
    end
    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    require("lspconfig")[server].setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
  end
}

EOF
