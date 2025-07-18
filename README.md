# Neovim設定 (2025年版)

[![Neovim](https://img.shields.io/badge/Neovim-0.9.0+-green.svg)](https://neovim.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

モダンなNeovim設定。LSP、AI支援、高速検索、Git統合などを含む完全な開発環境。

## 目次

1. [必要なもの](#必要なもの)
2. [クイックスタート](#クイックスタート)
3. [機能一覧](#機能一覧)
4. [キーバインド](#キーバインド)
5. [AI機能のセットアップ](#ai機能のセットアップ)
6. [トラブルシューティング](#トラブルシューティング)

## 必要なもの

### 必須
- **Neovim** >= 0.9.0
- **Git**
- **gcc** または **clang** (Treesitter用)
- **Node.js** >= 16 (LSPとCopilot用)
- **ripgrep** (高速検索用)

### オプション
- **fd** (より高速なファイル検索)
- **Python3** + pip
- **cargo** (Rust製ツール用)
- **Nerd Font** (アイコン表示用)

### インストールコマンド (Ubuntu/WSL2)
```bash
# 基本ツール
sudo apt update
sudo apt install -y git gcc g++ make ripgrep python3 python3-pip

# Neovim (最新版)
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

# Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# fd (オプション)
sudo apt install -y fd-find
ln -s $(which fdfind) ~/.local/bin/fd
```

## クイックスタート

### 1. 設定のクローン
```bash
# 既存の設定をバックアップ
mv ~/.config/nvim ~/.config/nvim.bak

# この設定をクローン
git clone https://github.com/[username]/nvim-config.git ~/.config/nvim
```

### 2. 初回起動
```bash
nvim
```
初回起動時に自動的に：
- lazy.nvimがインストールされる
- すべてのプラグインがダウンロードされる
- TreesitterがParserをコンパイルする
- LSPサーバーがインストールされる

### 3. ヘルスチェック
```vim
:checkhealth
```

## 機能一覧

### 🚀 コア機能
- **lazy.nvim** - 高速なプラグイン管理
- **LSP** - 自動補完、診断、フォーマット
- **Treesitter** - 高度なシンタックスハイライト
- **Telescope** - ファジーファインダー
- **Which-key** - キーバインドヘルプ

### 📝 エディタ拡張
- **Neo-tree** - ファイルエクスプローラー
- **Vista** - コードアウトライン/タグバー
- **Flash.nvim** - 高速カーソル移動
- **Comment.nvim** - コメント操作
- **nvim-surround** - 括弧・クォート操作
- **yanky.nvim** - ヤンク履歴管理
- **undotree** - 詳細なアンドゥ履歴

### 🤖 AI支援
- **GitHub Copilot** - AIコード補完
- **avante.nvim** - AIチャット（Ollama対応）
- **vim-translator** - 翻訳機能

### 🔧 開発ツール
- **gitsigns** - Git差分表示
- **fugitive** - Git操作
- **Mason** - LSPサーバー管理
- **nvim-cmp** - 高度な自動補完

### 🎨 UI/UX
- **tokyonight** - カラースキーム
- **lualine** - ステータスライン
- **transparent.nvim** - 背景透過
- **nvim-web-devicons** - ファイルアイコン

## キーバインド

詳細は `:help my-keybindings` を参照。

### 最重要キーバインド
| キー | 説明 |
|------|------|
| `<Space>` | リーダーキー |
| `::` | 最近のファイル |
| `<leader>ff` | ファイル検索 |
| `<leader>fg` | 全文検索 |
| `<F2>` | ファイルツリー |
| `<F3>` | アンドゥツリー |
| `<F4>` | AI チャット |
| `<F9>` | コードアウトライン |
| `<leader><leader>` | Telescopeメニュー |
| `<leader>aa` | AIに質問 |

## AI機能のセットアップ

### 方法1: Ollama (完全無料・ローカル)

1. Ollamaをインストール
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

2. モデルをダウンロード
```bash
ollama pull codellama:7b    # コード特化
ollama pull llama3.2:3b     # 汎用（日本語対応）
```

3. 起動（自動起動設定済み）
```bash
ollama-daemon start
```

### 方法2: GitHub Copilot (月額$10)

1. GitHub Copilotに登録
2. Neovimで認証
```vim
:Copilot setup
```

### 方法3: 他のAIプロバイダー

avante-ollama.luaの`provider`を変更：
- `claude` - Anthropic Claude
- `openai` - OpenAI GPT
- `gemini` - Google Gemini

## ディレクトリ構造

```
~/.config/nvim/
├── init.lua                 # メインエントリポイント
├── lua/
│   ├── config/             # 基本設定
│   │   ├── options.lua     # エディタオプション
│   │   ├── keymaps.lua     # キーマッピング
│   │   └── autocmds.lua    # 自動コマンド
│   └── plugins/            # プラグイン設定
│       ├── lsp.lua         # LSP設定
│       ├── telescope.lua   # 検索設定
│       ├── treesitter.lua  # シンタックス
│       └── ...             # その他プラグイン
├── doc/
│   └── my-keybindings.txt  # カスタムヘルプ
└── README.md               # このファイル
```

## カスタマイズ

### プラグインの追加
`lua/plugins/`に新しいファイルを作成：
```lua
-- lua/plugins/example.lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",
    config = function()
      require("plugin-name").setup({})
    end,
  },
}
```

### キーマップの変更
`lua/config/keymaps.lua`を編集

### LSPサーバーの追加
```vim
:Mason
```
でUIを開いて選択・インストール

## トラブルシューティング

### プラグインが読み込まれない
```vim
:Lazy sync
```

### LSPが動作しない
```vim
:LspInfo
:Mason
```

### 透明度が効かない
```vim
:TransparentEnable
```

### パフォーマンスが悪い
```vim
:Lazy profile
```

### Ollamaが動作しない
```bash
ollama-daemon status
ollama-daemon restart
```

## 更新方法

```bash
cd ~/.config/nvim
git pull
nvim +Lazy sync +qa
```

## アンインストール

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

## ライセンス

MIT

## 貢献

Issue、PR歓迎です！

---

Happy Vimming! 🚀