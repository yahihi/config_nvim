return {
  {
    "gbprod/yanky.nvim",
    dependencies = {
      { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") },
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("yanky").setup({
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
        },
        picker = {
          telescope = {
            use_default_mappings = true,
            mappings = nil,
          },
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 200,
        },
        preserve_cursor_position = {
          enabled = true,
        },
      })
      
      -- Telescope integration
      require("telescope").load_extension("yank_history")
    end,
    keys = {
      { "<leader>uy", "<cmd>Telescope yank_history<cr>", desc = "Yank History" },
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
      { "<c-n>", "<Plug>(YankyCycleForward)" },
      { "<c-p>", "<Plug>(YankyCycleBackward)" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)" },
      { "=p", "<Plug>(YankyPutAfterFilter)" },
      { "=P", "<Plug>(YankyPutBeforeFilter)" },
    },
  },
}