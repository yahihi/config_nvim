-- MCPHub.nvim - MCPサーバー統合プラグイン
return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- グローバルインストール（推奨）
    build = "npm install -g mcp-hub@latest",
    event = "VeryLazy",
    config = function()
      require("mcphub").setup({
        -- MCPハブの基本設定
        use_bundled_binary = false, -- グローバルインストールを使用
        
        -- デバッグモード（問題があれば有効にする）
        debug = false,
        
        -- グローバル環境変数の設定
        global_env = function(context)
          local env = {
            "HOME",
            "PATH",
            "NODE_PATH",
          }
          -- ワークスペースモードの場合はルートを追加
          if context.is_workspace_mode then
            env.WORKSPACE_ROOT = context.workspace_root
          end
          return env
        end,
        
        -- 拡張機能の設定
        extensions = {
          -- avante.nvimとの統合
          avante = {
            -- MCPサーバーのプロンプトから
            -- スラッシュコマンドを作成
            make_slash_commands = true,
          },
        },
        
        -- 自動承認の設定（開発時は便利）
        auto_approve = function(server_name, tool_name, args)
          -- ローカルRAGサーバーのファイル読み取りは自動承認
          if server_name == "local-rag" then
            if tool_name == "read_file" or 
               tool_name == "search" or
               tool_name == "list_files" then
              return true
            end
          end
          return false
        end,
      })
      
      -- キーマッピング
      local map = vim.keymap.set
      
      -- MCPハブのUI
      map("n", "<leader>mh", ":McpHub<CR>", 
        { desc = "MCP Hub: UIを開く" })
      map("n", "<leader>ms", ":McpHub servers<CR>", 
        { desc = "MCP Hub: サーバー一覧" })
      map("n", "<leader>mt", ":McpHub tools<CR>", 
        { desc = "MCP Hub: ツール一覧" })
      map("n", "<leader>mr", ":McpHub resources<CR>", 
        { desc = "MCP Hub: リソース一覧" })
      map("n", "<leader>ml", ":McpHub logs<CR>", 
        { desc = "MCP Hub: ログ表示" })
      
      -- サーバー管理
      map("n", "<leader>mR", ":McpHub restart<CR>", 
        { desc = "MCP Hub: 全サーバー再起動" })
      map("n", "<leader>mS", ":McpHub stop<CR>", 
        { desc = "MCP Hub: 全サーバー停止" })
    end,
  },
}