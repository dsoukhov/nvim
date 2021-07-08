require('formatter').setup({
  logging = false,
  filetype = {
    go = {
       function()
          return {
            exe = "",
            args = {},
            stdin = true
          }
        end
    },
    python = {
       function()
          return {
            exe = "",
            args = {},
            stdin = true
          }
        end
    },
    javascript = {
        -- prettier
       function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
            stdin = true
          }
        end
    },
    rust = {
      -- Rustfmt
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout"},
          stdin = true
        }
      end
    },
    c = {
      function()
        return {
          exe = "clang-format",
          args = {"--style=GNU"},
          stdin = true
        }
      end
    },
    cpp = {
      function()
        return {
          exe = "clang-format",
          args = {"--style=GNU"},
          stdin = true
        }
      end
    },
    java = {
      function()
        return {
          exe = "clang-format",
          args = {"--style=GNU"},
          stdin = true
        }
      end
    },
    h = {
      function()
        return {
          exe = "clang-format",
          args = {"--style=GNU"},
          stdin = true
        }
      end
    },
    lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
  }
})
