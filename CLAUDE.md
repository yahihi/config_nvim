# Neovim設定 - Claude用コンテキスト

このファイルは、Claudeとの継続的な相談のためのコンテキスト情報です。

#CLAUDE.local.md

## 現在の環境
- **OS**: クロスプラットフォーム対応（Linux/macOS/Windows/WSL）
- **Neovim**: 最新版
- **プラグインマネージャー**: lazy.nvim
- **自動検出**: OS別のコマンドを自動選択（fd/fdfind/fd.exe）

## 主要な設定構造
```
~/.config/nvim/
├── init.lua              # エントリーポイント（lazy.nvimのブートストラップ）
├── lua/
│   ├── config/          # 基本設定
│   │   ├── options.lua  # エディタオプション
│   │   ├── keymaps.lua  # キーマッピング
│   │   └── autocmds.lua # 自動コマンド
│   └── plugins/         # プラグイン設定（個別ファイル）
├── after/plugin/        # プラグイン読み込み後の追加設定
├── doc/                 # Vimヘルプファイル
└── docs/                # ドキュメント
```

## 重要な設定内容

### Telescope
- **find_files**: `fdfind`を使用（`--strip-cwd-prefix`が必須）
- **live_grep**: `additional_args = { "--hidden" }`が必要
- キーマップ: `<leader>ff`, `<leader>fg`

### AI支援 (avante.nvim)
- **プロバイダー**: OpenAI API (gpt-4o-mini)
- **環境変数**: `OPENAI_API_KEY`（Fishシェル）
- **サイドバー**: `<F4>`でトグル
- **キーマップ**: `<leader>ae`（編集）, `<leader>aa`（質問）

### エディタ設定
- **リーダーキー**: `<Space>`
- **80文字折り返し**: `textwidth=80`, `formatoptions`に`t`を含む
- **コンテキスト表示**: nvim-treesitter-context使用

## 既知の問題と解決策

### 1. Telescopeの外部コマンド問題
- WSL2環境では外部コマンドの出力解析に問題が発生することがある
- `fdfind`には`--strip-cwd-prefix`オプションが必須
- `live_grep`では`--hidden`を`additional_args`で指定

### 2. avante.nvimとOllama
- Ollamaモデルはavante.nvimのeditモードで差分表示ができない（既知の問題）
- OpenAI APIを推奨

## よくある質問と回答

### Q: プラグインを追加したい
A: `lua/plugins/`に新しいファイルを作成。例：
```lua
-- lua/plugins/新機能.lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",  -- 遅延読み込み
    opts = {
      -- オプション
    },
  },
}
```

### Q: キーマップを変更したい
A: `lua/config/keymaps.lua`を編集

### Q: 新しいLSPを追加したい
A: `lua/plugins/lsp.lua`の`ensure_installed`に追加

## 今後の改善予定
- [ ] デバッグ機能（DAP）の追加
- [ ] テスト実行環境の整備
- [ ] プロジェクト固有の設定（.nvim.lua）

## 相談時の注意事項
1. エラーメッセージは全文を共有してください
2. `:checkhealth`の結果も有用です
3. 設定変更前は必ずバックアップを取ってください

## 最終更新
- 2024年7月（完全復旧完了）
- すべての機能が正常動作することを確認済み
