return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
        aliases = {
          ["a"] = ">",
          ["b"] = ")",
          ["B"] = "}",
          ["r"] = "]",
          ["q"] = { '"', "'", "`" },
          ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
        },
        highlight = {
          duration = 0,
        },
        move_cursor = "begin",
        indent_lines = function(start, stop)
          local b = vim.bo
          -- Only re-indent the selection if a formatter is set up already
          if b.equalprg ~= "" or b.indentexpr ~= "" or b.cindent or b.smartindent or b.lisp then
            vim.cmd(string.format("silent normal! %dG=%dG", start, stop))
          end
        end,
      })
    end,
  },
}