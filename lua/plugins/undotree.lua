return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<F3>", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_DiffpanelHeight = 10
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_HelpLine = 1
      vim.g.undotree_DiffCommand = "diff"
    end,
  },
}