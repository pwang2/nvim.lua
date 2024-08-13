return{
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "lua_ls",
          "cssls",
          "html",
          "jsonls",
          "tsserver",
          "pyright",
          "volar",
          "tailwindcss",
          'rust_analyzer',
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies={
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim'
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require('lspconfig')
      local lspConfigUtil = require 'lspconfig.util'

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        -- opts.border = opts.border or 'single'
        opts.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
        opts.max_width = opts.max_width or 80
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      local on_attach = function(_, bufnr)
        local bkm = vim.api.nvim_buf_set_keymap
        local km = vim.api.nvim_set_keymap
        local kb_opts = { noremap = true, silent = true }
        local mkmp = function(key, cmd)
          vim.lsp.util.make_floating_popup_options(80, 20)
          bkm(bufnr, 'n', key, '<cmd>lua vim.lsp.buf.' .. cmd .. '()<CR>', kb_opts)
        end

        mkmp('gD', 'declaration')
        mkmp('gd', 'definition')
        mkmp('K', 'hover')
        mkmp('gi', 'implementation')
        mkmp('<space>k', 'signature_help')
        mkmp('<space>D', 'type_definition')
        mkmp('<space>rn', 'rename')
        mkmp('<space>ca', 'code_action')
        mkmp('<space>f', 'format') -- use Neoformat
        -- mkmp('gr', 'references') -- use trouble gr

        km('n', '<space>e', '<cmd>lua vim.diagnostic.open_float({width = 80})<CR>', kb_opts)
        km('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', kb_opts)
        km('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', kb_opts)
        km('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', kb_opts)
        km('n', 'gv', '<cmd>:vsplit | lua vim.lsp.buf.definition()<CR>', kb_opts)
      end

      --Enable (broadcasting) snippet capability for completion
      local c = vim.lsp.protocol.make_client_capabilities()
      c.textDocument.completion.completionItem.snippetSupport = true
      --Enable (broadcasting) snippet capability for completion
      local capabilities = require 'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities())
      lspConfigUtil.default_config = vim.tbl_extend('force', lspConfigUtil.default_config, {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.rust_analyzer.setup {}
      lspconfig.tailwindcss.setup {
        filetypes = { 'vue', 'html', 'css', 'javascript', 'typescript' },
      }

      lspconfig.gopls.setup {}

      lspconfig.pyright.setup {}

      lspconfig.lua_ls.setup {
        settings = { Lua = { diagnostics = { globals = { 'vim', 'hs', 'spoon' } } } },
      }

      lspconfig.tsserver.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "",
              languages = { "javascript", "typescript", "vue" },
            },
          },
        },
        filetypes = {
          "javascript",
          "typescript",
          "vue",
        },
      }
    end
  }
}

