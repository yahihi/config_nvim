return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      
      -- Register key groups
      wk.add({
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "hunk" },
        { "<leader>l", group = "lsp" },
        { "<leader>s", group = "search" },
        { "<leader>t", group = "translate/terminal" },
        { "<leader>n", group = "new" },
        { "<leader>r", group = "rename/reload" },
        { "<leader>c", group = "code" },
        { "<leader>b", group = "buffer" },
        { "<leader>u", group = "ui" },
        { "<leader>x", group = "diagnostics/quickfix" },
        { "g", group = "goto" },
        { "]", group = "next" },
        { "[", group = "prev" },
      })
    end,
  },
}