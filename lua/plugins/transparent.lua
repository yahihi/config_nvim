return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      require("transparent").setup({
        groups = {
          "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
          "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
          "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
          "SignColumn", "CursorLineNr", "EndOfBuffer",
        },
        extra_groups = {
          "NormalFloat",
          "NeoTreeNormal",
          "NeoTreeNormalNC",
          "NeoTreeVertSplit",
          "NeoTreeWinSeparator",
          "NeoTreeEndOfBuffer",
          "NeoTreeRootName",
          "NeoTreeGitAdded",
          "NeoTreeGitDeleted",
          "NeoTreeGitModified",
          "NeoTreeGitConflict",
          "NeoTreeGitUntracked",
          "NeoTreeIndentMarker",
          "NeoTreeExpander",
          "NeoTreeCursorLine",
        },
        exclude_groups = {},
      })
      
      -- 透明化を有効にする
      vim.cmd("TransparentEnable")
    end,
  },
}