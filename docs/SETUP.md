# Neovim セットアップ詳細ガイド

## 完全新規インストール手順

### ステップ1: 環境準備

#### WSL2/Ubuntu
```bash
# システムアップデート
sudo apt update && sudo apt upgrade -y

# 必須パッケージ
sudo apt install -y \
  curl \
  git \
  gcc \
  g++ \
  make \
  unzip \
  ripgrep \
  python3 \
  python3-pip \
  python3-venv

# Neovim最新版
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim

# Node.js (LSP用)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Neovim用のNode.jsプロバイダー（オプション）
npm install -g neovim

# Python用pynvim（オプション）
# macOS/最新のLinuxでは専用仮想環境が必須
python3 -m venv ~/.config/nvim/pynvim-env
~/.config/nvim/pynvim-env/bin/pip install pynvim

# 注: 設定ファイルで自動的にこの環境を使用するよう設定済み

# 確認
nvim --version  # 0.9.0以上
node --version  # v16以上
rg --version    # ripgrep
```

### ステップ2: フォントインストール（アイコン表示用）

#### Windows側（WSL2の場合）
1. [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases)をダウンロード
2. zipを解凍してフォントをインストール
3. Windowsターミナルの設定でフォントを変更

### ステップ3: 設定ファイルのセットアップ

```bash
# 既存設定のバックアップ
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak.$(date +%Y%m%d)

# 設定をクローン（このリポジトリから）
git clone [repository-url] ~/.config/nvim

# または手動でコピー
mkdir -p ~/.config/nvim
cp -r /path/to/this/config/* ~/.config/nvim/
```

### ステップ4: 初回起動と自動セットアップ

```bash
# Neovimを起動（自動でプラグインがインストールされる）
nvim

# しばらく待つ（以下が自動実行される）：
# 1. lazy.nvimのブートストラップ
# 2. プラグインのダウンロード
# 3. Treesitterのコンパイル
# 4. LSPサーバーのインストール
```

### ステップ5: ヘルスチェック

```vim
:checkhealth
```

期待される結果：
- ✓ Neovim version
- ✓ Terminal emulator
- ✓ ripgrep found
- ✓ node found
- ✓ Python 3 provider

### ステップ6: LSPサーバーの追加インストール

```vim
:Mason
```
必要な言語のLSPを選んでインストール（iキー）

### ステップ7: AI機能のセットアップ

#### Ollama（推奨・無料）
```bash
# インストール
curl -fsSL https://ollama.com/install.sh | sh

# モデルダウンロード
ollama pull codellama:7b

# 自動起動設定
~/.local/bin/ollama-daemon start
```

#### GitHub Copilot（有料）
```vim
:Copilot setup
" ブラウザで認証
```

### ステップ8: 環境変数の設定（オプション）

```bash
# ~/.bashrcまたは~/.zshrcに追加

# fishの場合
echo 'set -x OPENAI_API_KEY "dummy"' >> ~/.config/fish/config.fish

# bashの場合
echo 'export OPENAI_API_KEY="dummy"' >> ~/.bashrc
source ~/.bashrc
```

#### Python仮想環境を使っている場合

Neovim専用のPython環境を作成し、設定ファイルで指定：

```lua
-- lua/config/options.luaに追加
-- システムPythonを使う場合
vim.g.python3_host_prog = '/usr/bin/python3'

-- または専用仮想環境を使う場合
vim.g.python3_host_prog = vim.fn.expand('~/.config/nvim/pynvim-env/bin/python')
```

これにより、他の仮想環境に影響されずに
Neovimが常に同じPython環境を使用します

### ステップ9: カスタムヘルプの有効化

```vim
:helptags ~/.config/nvim/doc
:help my-keybindings
```

## プラットフォーム別の注意事項

### WSL2
- クリップボード共有: win32yankがなくても動作
- パフォーマンス: Windows Defenderの除外設定推奨
- Ollama: WSL2内で問題なく動作

### macOS
```bash
# Homebrew経由
brew install neovim ripgrep node fd

# Neovim用のプロバイダー（オプション）
npm install -g neovim
pip3 install -U pynvim

# フォント
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

### Linux (ネイティブ)
- 多くのディストリビューションで動作確認済み
- Waylandでも問題なし

## よくある質問

### Q: プラグインがインストールされない
A: `:Lazy sync`を実行

### Q: LSPが動かない
A: `:Mason`でLSPサーバーをインストール、`:LspInfo`で確認

### Q: 文字化けする
A: Nerd Fontをインストールしてターミナルで設定

### Q: 起動が遅い
A: 初回はTreesitterのコンパイルで時間がかかります。2回目以降は高速です。

### Q: Copilotが動かない
A: `:Copilot status`で確認、`:Copilot setup`で再認証

## パフォーマンスチューニング

### 起動時間の計測
```vim
:StartupTime
```

### 不要なプラグインの無効化
`lua/plugins/`から不要なファイルを削除またはリネーム（.bak追加）

### キャッシュクリア
```bash
rm -rf ~/.cache/nvim
rm -rf ~/.local/state/nvim/lazy
```

## バックアップとリストア

### 設定のバックアップ
```bash
cd ~/.config
tar -czf nvim-backup-$(date +%Y%m%d).tar.gz nvim/
```

### リストア
```bash
tar -xzf nvim-backup-20250117.tar.gz -C ~/.config/
```

## 開発のヒント

1. **新しいプラグインを試す**: `lua/plugins/test.lua`を作成
2. **設定の再読み込み**: `:source %`または`:Lazy reload`
3. **デバッグ**: `:lua print(vim.inspect(...))`
4. **プロファイル**: `:Lazy profile`

---

セットアップで問題があれば、Issueを作成してください！