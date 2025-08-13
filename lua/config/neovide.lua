-- Neovide specific settings
if vim.g.neovide then
  -- フォント設定（プラットフォーム別）
  if vim.fn.has("mac") == 1 then
    -- macOS
    vim.o.guifont = "HackGen35 Console NF:h20"
  elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    -- Windows
    vim.o.guifont = "HackGen35 Console NF:h16"
  else
    -- Linux/WSL
    vim.o.guifont = "HackGen35 Console NF:h16"
  end
  
  -- 透明度設定（0.0〜1.0）- v0.15から変更
  vim.g.neovide_opacity = 0.8
  
  -- カーソルアニメーション
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_antialiasing = true
  
  -- パフォーマンス設定
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  
  -- ウィンドウ設定
  vim.g.neovide_remember_window_size = true
  
  -- macOS専用設定
  if vim.fn.has("mac") == 1 then
    vim.g.neovide_input_macos_option_key_is_meta = "both"  -- v0.15から変更 ("both", "only_left", "only_right", "none")
  end
  
  -- フルスクリーン切り替え
  vim.keymap.set("n", "<F11>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Toggle fullscreen" })
  
  -- フォントサイズ調整
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1/1.25)
  end)
  
  -- macOS用の設定
  if vim.fn.has("mac") == 1 then
    vim.keymap.set({"n", "v", "i"}, "<D-v>", '"+p', { desc = "Paste from clipboard" })
    vim.keymap.set({"n", "v"}, "<D-c>", '"+y', { desc = "Copy to clipboard" })
    vim.keymap.set("i", "<D-c>", '<Esc>"+yi', { desc = "Copy to clipboard" })
  end
end
