-- Treesitter Context - スクロール時に関数名/クラス名を表示
return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
    config = function(_, opts)
      require('treesitter-context').setup(opts)
      
      -- キーマップ設定
      vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context()
      end, { silent = true, desc = "Jump to context" })
      
      -- ハイライト設定
      vim.api.nvim_set_hl(0, 'TreesitterContext', { link = 'CursorLine' })
      vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { link = 'LineNr' })
      vim.api.nvim_set_hl(0, 'TreesitterContextSeparator', { link = 'Comment' })
    end,
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
  },
}