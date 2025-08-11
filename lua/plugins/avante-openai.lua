-- Gemini API設定のavante.nvim（MCP統合付き）
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = function()
      -- MCPハブのインスタンスを取得
      local hub = nil
      pcall(function()
        hub = require("mcphub").get_hub_instance()
      end)
      
      return {
        provider = "gemini",
        providers = {
          gemini = {
            model = "gemini-1.5-flash",  -- 無料プランで使用可能
            timeout = 30000,
            temperature = 0.7,
            max_tokens = 4096,
            -- APIキーは環境変数から読み込まれます: GEMINI_API_KEY または AVANTE_GEMINI_API_KEY
          },
        },
        behaviour = {
          auto_suggestions = false,
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = false,  -- 自動適用を無効化
          support_paste_from_clipboard = false,
        },
        windows = {
          edit = {
            border = "rounded",
            start_insert = true,
          },
          ask = {
            floating = true,
            start_insert = true,
            border = "rounded",
          },
          diff = {
            keymaps = {
              accept = "ca",  -- 変更を適用
              reject = "co",  -- 変更を拒否
            },
          },
        },
        diff = {
          autojump = false,
          list_opener = "copen",
        },
        hints = { enabled = true },
        
        -- MCPハブとの統合
        system_prompt = function()
          local base_prompt = [[あなたは日本語で回答するプログラミングアシスタントです。
すべての回答は日本語で行ってください。
コードのコメントも日本語で書いてください。
英語で質問されても日本語で回答してください。]]
          
          -- MCPサーバーのプロンプトを追加
          if hub then
            local mcp_prompt = hub:get_active_servers_prompt()
            if mcp_prompt and mcp_prompt ~= "" then
              return base_prompt .. "\n\n" .. mcp_prompt
            end
          end
          return base_prompt
        end,
        
        -- MCPツールを追加
        custom_tools = function()
          local tools = {}
          -- MCPツールが利用可能な場合は追加
          pcall(function()
            local mcp_tool = require("mcphub.extensions.avante").mcp_tool()
            if mcp_tool then
              table.insert(tools, mcp_tool)
            end
          end)
          return tools
        end,
      }
    end,
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}