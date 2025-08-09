-- Snacks.nvim - 便利なユーティリティ集
-- Claude Codeのターミナルサポートにも使用
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("snacks").setup({
        -- ターミナル機能
        terminal = {
          enabled = true,
          win = {
            border = "rounded",
          },
        },
        
        -- 通知機能
        notifier = {
          enabled = true,
          timeout = 3000,
        },
        
        -- その他の便利機能
        bigfile = { enabled = true },  -- 大きなファイルの最適化
        quickfile = { enabled = true }, -- ファイルの高速オープン
        statuscolumn = { enabled = false }, -- ステータスカラム（他で設定済み）
        words = { enabled = true }, -- 単語のハイライト
        
        -- インデントアニメーション（お好みで）
        indent = {
          enabled = false,  -- インデントラインは他で設定済み
        },
      })
    end,
    keys = {
      -- ターミナル関連のキーマップ
      { "<c-/>", function() require("snacks").terminal.toggle() end, desc = "ターミナル: トグル" },
      { "<c-_>", function() require("snacks").terminal.toggle() end, desc = "ターミナル: トグル" },
      
      -- ターミナルモードでのエスケープ
      { "<esc><esc>", "<c-\\><c-n>", desc = "ターミナル: ノーマルモード", mode = "t" },
    },
  },
}