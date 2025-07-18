# Telescope find_files 修正完了！

## 問題の原因
Ubuntu/Debianでは`fd`が`fdfind`としてインストールされ、デフォルトで`./`プレフィックスが付くため、Telescopeが正しく解析できませんでした。

## 解決策
`--strip-cwd-prefix`オプションを追加することで解決しました。

## 最終的な設定
```lua
find_command = { 'fdfind', '--type', 'f', '--strip-cwd-prefix', '--hidden', '--exclude', '.git' }
```

## 動作確認済みの機能
- `<leader>ff` - ファイル検索（高速）
- `<leader>fg` - テキスト検索（ripgrep使用）
- `<leader>fb` - バッファ一覧
- `<leader><leader>` - Telescope機能一覧

## 重要なポイント
- `--strip-cwd-prefix`: `./`プレフィックスを削除（必須）
- `--hidden`: 隠しファイルも表示
- `--exclude .git`: .gitディレクトリを除外

これでTelescopeが高速に動作するようになりました！