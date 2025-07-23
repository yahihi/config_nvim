-- Telescope live_grep キーマップ修正
-- after/pluginディレクトリで実行されるため、確実に適用される

local builtin = require('telescope.builtin')

-- live_grepのキーマップを上書き
vim.keymap.set('n', '<leader>fg', function()
  builtin.live_grep({
    additional_args = { "--hidden" },
  })
end, { desc = 'Live Grep (with hidden files)' })

-- 追加のキーマップ
vim.keymap.set('n', '<leader>fG', function()
  builtin.live_grep({
    additional_args = { "--hidden", "--no-ignore" },
  })
end, { desc = 'Live Grep (all files)' })

-- print("✅ live_grepキーマップを修正しました")