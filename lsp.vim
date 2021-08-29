lua << EOF

-- compe config
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    spell = true;
    path = true;
    buffer = true;
    vsnip = true;
    treesitter = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}

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
  buf_set_keymap('n', 'gca', '<cmd>Telescope lsp_code_actions<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', 'H', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  --buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>Telescope lsp_workspace_diagnostics<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>Telescope lsp_document_diagnostics<CR>', opts)
  --buf_set_keymap('n', '<space>l', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  require "lsp_signature".on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    hint_prefix = "",
    handler_opts = {
      border = "single"
    },
  })
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

local clangd_settings = {
  clangd = {
    filetypes = { "c", "cpp" },
    rootPatterns = { "compile_commands.json", ".git", "Makefile" },
    args = {
      "-j=6",
      --"--limit-results=0",
      --"--cross-file-rename",
      --"--compile_args_from=filesystem",
      --"--all-scopes-completion",
      --"--background-index",
      ----https://clangd.llvm.org/config.html
      ----set project config in .clangd at root
      --"--enable-config",
      --"--completion-parse=always",
      --"--completion-style=detailed",
      --"--function-arg-placeholders",
      --"--header-insertion-decorators",
      --"--header-insertion=never",
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

    workspace = {
      maxPreload = 5000,
      preloadFileSize = 5000,
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  } return {
    capabilities = capabilities,
    -- enable signature support
    on_attach = on_attach
  }
end

-- lsp-install lua, java, cpp, json, cmake, latex, python, ruby, rust, vim
-- yaml, vim, typescript, docker, angular, dockerfile, html, php
local function setup_servers()
  --nvim-lspinstall setup for autoinstall languages
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    local config = make_config()
    if server == "cpp" then
      config.settings = clangd_settings
    elseif server == "lua" then
      config.settings = lua_settings
    end
    nvim_lsp[server].setup(config)
  end
  local null_cfg = make_config()
  nvim_lsp["null-ls"].setup(null_cfg)
end

-- null-ls cfg
local null_ls = require("null-ls")
null_ls.config({
  sources = {
      --add sources here
      --require("null-ls.helpers").conditional(function(utils)
      --  return utils.root_has_file(".eslintrc.js") and null_ls.builtins.formatting.eslint_d or null_ls.builtins.formatting.prettierd
      --end),
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.diagnostics.eslint.with({
        command = "eslint_d"
      }),
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.diagnostics.shellcheck,
  }
})
setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
EOF
