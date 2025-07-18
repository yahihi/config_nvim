# avante.nvim 動作確認完了！

## ✅ 動作確認済み機能

### OpenAI APIでの編集機能
- `<leader>ae` で編集モード
- 差分表示が正しく動作
- 日本語での応答

### 使い方のまとめ

1. **編集モード** (`<leader>ae`)
   - コードを選択
   - プロンプト入力
   - 差分確認後、適用/拒否

2. **質問モード** (`<leader>aa`)
   - 質問を入力
   - 日本語で回答を取得

3. **キーマップ**
   - `<leader>ae` - 編集
   - `<leader>aa` - 質問
   - `<leader>ar` - リフレッシュ
   - `<leader>at` - トグル

## 注意事項
- Ollama版は差分表示に問題があるため、OpenAI APIを使用中
- APIキーは環境変数で管理（セキュア）
- gpt-4o-miniモデルを使用（コスト効率的）

## LSPについて
「No Active LSP」は現在のファイルタイプにLSPが設定されていないだけです。
- `.py` ファイル → pyright
- `.js/.ts` ファイル → ts_ls
- `.lua` ファイル → lua_ls

が自動的に起動します。