-- Quickfixウィンドウの自動クローズ設定

-- quickfixウィンドウからジャンプ後に自動で閉じる
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    -- quickfixウィンドウでEnterを押したときの動作を設定
    vim.keymap.set("n", "<CR>", function()
      -- 現在の行のquickfixエントリを取得
      local qf_idx = vim.fn.line('.')
      -- そのエントリにジャンプ
      vim.cmd(string.format("cc %d", qf_idx))
      -- quickfixウィンドウを閉じる
      vim.cmd("cclose")
    end, { buffer = true, desc = "Jump and close quickfix" })
    
    -- oキーでもジャンプして閉じる
    vim.keymap.set("n", "o", function()
      local qf_idx = vim.fn.line('.')
      vim.cmd(string.format("cc %d", qf_idx))
      vim.cmd("cclose")
    end, { buffer = true, desc = "Jump and close quickfix" })
    
    -- プレビューしながら選択する場合（pキー）
    vim.keymap.set("n", "p", function()
      local qf_idx = vim.fn.line('.')
      -- プレビューウィンドウで開く
      vim.cmd(string.format("cc %d", qf_idx))
      -- quickfixウィンドウにフォーカスを戻す
      vim.cmd("wincmd p")
    end, { buffer = true, desc = "Preview in quickfix" })
  end,
})

-- LSPの定義ジャンプをカスタマイズ（複数候補でもTelescopeを使う）
local function goto_definition_telescope()
  require("telescope.builtin").lsp_definitions({
    -- 単一の結果でも自動的にジャンプ
    jump_type = "never",
    -- プレビューを表示
    show_line = true,
  })
end

-- グローバル設定：LSPの定義ジャンプでTelescopeを優先的に使う
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    -- gdをTelescopeバージョンに置き換え
    vim.keymap.set("n", "gd", goto_definition_telescope, { 
      buffer = bufnr, 
      desc = "LSP: [G]oto [D]efinition (Telescope)" 
    })
  end,
})

-- オプション：quickfixウィンドウを使いたい場合のトグルコマンド
vim.g.use_telescope_for_lsp = true

vim.api.nvim_create_user_command("ToggleLspTelescope", function()
  vim.g.use_telescope_for_lsp = not vim.g.use_telescope_for_lsp
  if vim.g.use_telescope_for_lsp then
    vim.notify("Using Telescope for LSP navigation", vim.log.levels.INFO)
  else
    vim.notify("Using quickfix for LSP navigation", vim.log.levels.INFO)
  end
end, { desc = "Toggle between Telescope and quickfix for LSP" })