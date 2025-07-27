return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "md" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-web-devicons" },
    opts = {
      latex = { enabled = false },  -- LaTeXサポート無効化（警告対策）
      html = { enabled = false },   -- HTMLサポート無効化（警告対策）
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      -- Markdownファイルでhighlighterを有効化
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "md" },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}