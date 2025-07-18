-- OpenAI API設定のavante.nvim
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "openai",
      providers = {
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o-mini",  -- または "gpt-3.5-turbo", "gpt-4o"
          timeout = 30000,
          extra_request_body = {
            temperature = 0.7,
            max_tokens = 4096,
          },
          -- APIキーは環境変数から読み込まれます: OPENAI_API_KEY
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
      system_prompt = [[あなたは日本語で回答するプログラミングアシスタントです。
すべての回答は日本語で行ってください。
コードのコメントも日本語で書いてください。
英語で質問されても日本語で回答してください。]],
    },
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