return {
  {
    "liuchengxu/vista.vim",
    cmd = { "Vista", "Vf" },
    keys = {
      { "<F9>", "<cmd>Vista!!<cr>", desc = "Vista" },
      { "]t", "<cmd>lua require('vista.cursor').goto_next_top_level()<cr>", desc = "Next top level" },
      { "[t", "<cmd>lua require('vista.cursor').goto_prev_top_level()<cr>", desc = "Previous top level" },
    },
    config = function()
      vim.g.vista_default_executive = "nvim_lsp"
      vim.g.vista_fzf_preview = { "right:50%" }
      vim.g.vista_icon_indent = { "╰─▸ ", "├─▸ " }
      vim.g.vista_sidebar_width = 30
      vim.g.vista_echo_cursor_strategy = "both"
      vim.g.vista_stay_on_open = 0
      vim.g.vista_blink = { 2, 100 }
      vim.g.vista_top_level_blink = { 2, 100 }
      vim.g.vista_update_on_text_changed = 1
      vim.g.vista_update_on_text_changed_delay = 500
      vim.g.vista_close_on_jump = 0
      vim.g.vista_cursor_delay = 100
      vim.g.vista_ignore_kinds = {}
      vim.g.vista_executive_for = {
        vim = "ctags",
        lua = "nvim_lsp",
        python = "nvim_lsp",
        javascript = "nvim_lsp",
        typescript = "nvim_lsp",
        rust = "nvim_lsp",
      }
      
      -- Add Vf command as shortcut for Vista finder
      vim.cmd([[command! Vf Vista finder]])
    end,
  },
}