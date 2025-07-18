return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "folke/neodev.nvim",
    },
    config = function()
      -- Setup neodev for better Neovim Lua development
      require("neodev").setup()
      
      -- Setup mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ts_ls",
          "rust_analyzer",
        },
        automatic_installation = true,
      })
      
      -- LSP keymaps
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end
        
        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("gy", vim.lsp.buf.type_definition, "T[y]pe Definition")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        nmap("<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, "[F]ormat")
        nmap("]g", vim.diagnostic.goto_next, "Next Diagnostic")
        nmap("[g", vim.diagnostic.goto_prev, "Previous Diagnostic")
      end
      
      -- nvim-cmp capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      
      -- Setup language servers
      local lspconfig = require("lspconfig")
      
      -- Lua
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      
      -- Python
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- TypeScript
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- Rust
      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      })
      
      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },
  
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      
      -- Load friendly snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- Helper function to check if cursor is at the beginning of line
      local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
      end
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
                cmdline = "[CMD]",
              })[entry.source.name]
              return vim_item
            end,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<S-Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              cmp.complete()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500, keyword_length = 3 },
          { name = "path", priority = 250 },
        }),
        experimental = {
          ghost_text = true,
        },
        performance = {
          debounce = 60,
          throttle = 30,
          fetching_timeout = 200,
        },
      })
      
      -- Set configuration for specific filetype
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })
      
      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      
      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}