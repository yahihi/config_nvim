-- Claude Code統合プラグイン
-- WebSocketサーバーを作成し、Claude Code CLIと通信
return {
  {
    "coder/claudecode.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      local ok, claudecode = pcall(require, "claudecode")
      if not ok then
        vim.notify("claudecode.nvim not found", vim.log.levels.WARN)
        return
      end
      
      claudecode.setup({
        -- デバッグモードを無効化（エラーメッセージを抑制）
        debug = false,
        silent = true,
      })
    end,
    keys = {
      { 
        "<leader>ac", 
        function()
          local ok, _ = pcall(vim.cmd, "ClaudeCode")
          if not ok then
            vim.notify("Claude Code command not available", vim.log.levels.WARN)
          end
        end,
        desc = "Claude Code: トグル" 
      },
      { 
        "<leader>as", 
        function()
          local ok, _ = pcall(vim.cmd, "ClaudeCodeSend")
          if not ok then
            vim.notify("Claude Code Send command not available", vim.log.levels.WARN)
          end
        end,
        mode = "v", 
        desc = "Claude Code: 選択範囲を送信" 
      },
      {
        "<leader>ad",
        function()
          local ok, _ = pcall(vim.cmd, "ClaudeCodeDiff")
          if not ok then
            vim.notify("Claude Code Diff command not available", vim.log.levels.WARN)
          end
        end,
        desc = "Claude Code: Diff表示"
      },
      {
        "<leader>ar",
        function()
          local ok, _ = pcall(vim.cmd, "ClaudeCodeRestart")
          if not ok then
            vim.notify("Claude Code Restart command not available", vim.log.levels.WARN)
          end
        end,
        desc = "Claude Code: 再起動"
      },
    },
  },
}