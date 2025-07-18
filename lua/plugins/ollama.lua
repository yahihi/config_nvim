return {
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
        desc = "Ollama prompt",
        mode = { "n", "v" },
      },
      {
        "<leader>oG",
        ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
        desc = "Ollama Generate Code",
        mode = { "n", "v" },
      },
    },
    opts = {
      model = "codellama",
      url = "http://127.0.0.1:11434",
      serve = {
        on_start = false,
        command = "ollama",
        args = { "serve" },
        stop_command = "pkill",
        stop_args = { "-SIGTERM", "ollama" },
      },
      prompts = {
        Sample_Prompt = {
          prompt = "This is a sample prompt that receives $input and $sel(ection), among others.",
          input_label = "> ",
          model = "codellama",
          action = "display",
        },
        Generate_Code = {
          prompt = "Generate code for the following functionality: $input\nLanguage: $ftype\n",
          input_label = "> ",
          action = "insert",
        },
        Explain_Code = {
          prompt = "Explain the following code:\n$sel",
          action = "display",
        },
        Fix_Code = {
          prompt = "Fix the following code:\n$sel",
          action = "replace",
        },
      },
    },
  },
}