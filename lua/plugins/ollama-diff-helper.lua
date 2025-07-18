-- Ollama差分ヘルパー（手動差分確認付き）
return {
  {
    "nvim-lua/plenary.nvim",
    config = function()
      local function create_ollama_diff_command()
        vim.api.nvim_create_user_command("OllamaDiff", function(opts)
          local start_line = opts.line1
          local end_line = opts.line2
          local bufnr = vim.api.nvim_get_current_buf()
          local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
          local selected_text = table.concat(lines, "\n")
          local filename = vim.api.nvim_buf_get_name(bufnr)
          
          -- 一時ファイルに現在の内容を保存
          local temp_original = vim.fn.tempname() .. "_original.txt"
          local temp_modified = vim.fn.tempname() .. "_modified.txt"
          
          -- オリジナルを保存
          vim.fn.writefile(lines, temp_original)
          
          -- Ollamaにコード改善を依頼
          local prompt = string.format([[
以下のコードを改善してください。
ファイル名: %s
選択範囲: %d行目から%d行目

コード:
%s

改善されたコードのみを返してください（説明は不要）:]], filename, start_line, end_line, selected_text)
          
          -- Ollamaを呼び出し
          local Job = require("plenary.job")
          Job:new({
            command = "curl",
            args = {
              "-X", "POST",
              "http://localhost:11434/api/generate",
              "-d", vim.fn.json_encode({
                model = "llama3.2:3b",
                prompt = prompt,
                stream = false,
              }),
            },
            on_exit = function(j, return_val)
              if return_val == 0 then
                local result = j:result()
                local json_str = table.concat(result, "\n")
                local ok, decoded = pcall(vim.fn.json_decode, json_str)
                if ok and decoded.response then
                  -- 改善されたコードを一時ファイルに保存
                  local improved_lines = vim.split(decoded.response, "\n")
                  vim.fn.writefile(improved_lines, temp_modified)
                  
                  -- 差分を表示
                  vim.cmd(string.format("tabnew | diffthis | vsplit %s | diffthis | wincmd h | e %s", 
                    temp_modified, temp_original))
                  
                  -- 差分適用用のキーマップを設定
                  vim.api.nvim_buf_set_keymap(0, "n", "<leader>da", string.format(
                    [[:lua vim.api.nvim_buf_set_lines(%d, %d, %d, false, vim.fn.readfile('%s'))<CR>:tabclose<CR>]], 
                    bufnr, start_line - 1, end_line, temp_modified
                  ), { noremap = true, silent = true, desc = "差分を適用" })
                  
                  vim.api.nvim_buf_set_keymap(0, "n", "<leader>dr", 
                    ":tabclose<CR>", 
                    { noremap = true, silent = true, desc = "差分を拒否" })
                  
                  print("差分を確認してください。<leader>da で適用、<leader>dr で拒否")
                else
                  vim.notify("Ollamaからの応答の解析に失敗しました", vim.log.levels.ERROR)
                end
              else
                vim.notify("Ollamaへの接続に失敗しました", vim.log.levels.ERROR)
              end
            end,
          }):start()
        end, { range = true, desc = "Ollamaで選択範囲を改善（差分表示付き）" })
      end
      
      create_ollama_diff_command()
      
      -- キーマップ設定
      vim.keymap.set({ "n", "v" }, "<leader>od", ":OllamaDiff<CR>", 
        { noremap = true, silent = true, desc = "Ollama差分表示" })
    end,
  },
}