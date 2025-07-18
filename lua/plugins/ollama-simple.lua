-- シンプルなOllamaインテグレーション（avante.nvimの代替）
return {
  -- Ollamaとの直接対話用プラグイン
  {
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
    keys = {
      {
        "<leader>oo",
        ":<c-u>lua require('ollama').prompt()<cr>",
        desc = "Ollamaプロンプト",
        mode = { "n", "v" },
      },
      {
        "<leader>og",
        ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
        desc = "コード生成",
        mode = { "n", "v" },
      },
    },
    opts = {
      model = "llama3.2:3b",
      url = "http://127.0.0.1:11434",
      serve = {
        on_start = false,
        command = "ollama",
        args = { "serve" },
        stop_command = "pkill",
        stop_args = { "-SIGTERM", "ollama" },
      },
      -- カスタムプロンプト
      prompts = {
        Sample_Prompt = {
          prompt = "これは$selection（選択されたテキスト）についての日本語での説明です: $input",
          input_label = "> ",
          model = "llama3.2:3b",
          action = "display",
        },
        Generate_Code = {
          prompt = [[選択されたコード: $selection
質問: $input

日本語で説明し、改善されたコードを提案してください。]],
          input_label = "> ",
          action = "display",
        },
      }
    }
  },

  -- 差分表示用の補助プラグイン
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
  },
}