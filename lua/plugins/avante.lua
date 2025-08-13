-- avante.nvim - 複数プロバイダー設定
-- 環境変数 AVANTE_PROVIDER で切り替え可能 (デフォルト: lmstudio)
-- 使用例: export AVANTE_PROVIDER=openai
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = function()
      -- 環境変数からプロバイダーを選択（デフォルトはlmstudio）
      local provider = vim.env.AVANTE_PROVIDER or "lmstudio"
      
      return {
        provider = provider,
        providers = {
          -- LM Studio設定 (OpenAI互換API)
          lmstudio = {
            __inherited_from = "openai",  -- OpenAIプロバイダーを継承
            endpoint = "http://192.168.50.57:1234/v1",
            model = "openai/gpt-oss-20b",
            timeout = 30000,
            parse_api_key = function() return "dummy" end,  -- LM Studioではダミー値を返す
            extra_request_body = {
              temperature = 0.7,
              max_tokens = 4096,
            },
          },
          -- OpenAI API設定
          openai = {
            endpoint = "https://api.openai.com/v1",
            model = "gpt-4o-mini",
            timeout = 30000,
            -- APIキーは環境変数から読み込まれます: OPENAI_API_KEY
            extra_request_body = {
              temperature = 0.7,
              max_tokens = 4096,
            },
          },
        },
        behaviour = {
          auto_suggestions = false,
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = false,
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
              accept = "ca",
              reject = "co",
            },
          },
        },
        diff = {
          autojump = false,
          list_opener = "copen",
        },
        hints = { enabled = true },
        system_prompt = [[あなたは日本語で回答するプログラミングアシスタントです。
すべての回答は日本語で行ってください。
コードのコメントも日本語で書いてください。
英語で質問されても日本語で回答してください。]],
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