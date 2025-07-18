return {
  {
    "voldikss/vim-translator",
    cmd = { "Translate", "TranslateW", "TranslateR", "TranslateH", "TranslateL" },
    keys = {
      { "<leader>t", "<Plug>TranslateW", mode = { "n", "v" }, desc = "Translate" },
      { "<leader>tr", "<Plug>TranslateR", mode = { "n", "v" }, desc = "Translate Replace" },
      { "<leader>tw", "<Plug>TranslateWV", mode = "v", desc = "Translate Window" },
    },
    config = function()
      vim.g.translator_target_lang = "ja"
      vim.g.translator_source_lang = "auto"
      vim.g.translator_default_engines = { "google", "bing" }
      vim.g.translator_window_type = "popup"
      vim.g.translator_window_max_width = 0.6
      vim.g.translator_window_max_height = 0.6
      vim.g.translator_window_borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    end,
  },
}