# Neovim設定ドキュメント

## 主要な機能と設定

### 1. AI支援 (avante.nvim)
- **OpenAI API使用中** - `<leader>ae`で編集、`<leader>aa`で質問
- 設定詳細: `AVANTE_SUCCESS.md`
- APIキー設定: `OPENAI_SETUP_FISH.md`

### 2. ファイル検索 (Telescope)
- **fdfind使用で高速検索** - `<leader>ff`でファイル検索
- 修正内容: `TELESCOPE_FIXED.md`

### 3. テキスト設定
- **80文字折り返し** - 自動折り返し有効
- 詳細: `TEXT_WRAPPING.md`

### 4. コンテキスト表示
- **関数名/クラス名の固定表示** - スクロール時に上部に表示
- 詳細: `TREESITTER_CONTEXT.md`

### 5. セットアップ
- 初期設定手順: `SETUP.md`

## その他のドキュメント
- `AVANTE_SETUP.md` - avante.nvimの初期設定（参考用）
- `TELESCOPE_SOLUTION.md` - Telescope問題の解決経緯（参考用）