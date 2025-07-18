# クロスプラットフォーム対応

この設定は以下の環境で動作します：

## 対応OS
- **Linux** (Ubuntu, Debian, Arch, etc.)
- **macOS** 
- **Windows** (PowerShell/Windows Terminal推奨)
- **WSL/WSL2**

## 自動検出される設定

### ファイル検索コマンド (Telescope)
- **Linux/WSL**: `fdfind` または `fd`
- **macOS**: `fd` (Homebrewでインストール)
- **Windows**: `fd.exe` (scoopまたはchocolateyでインストール)

### シェル設定
- **Windows**: PowerShell (pwsh) または Windows PowerShell
- **その他**: デフォルトシェル

## セットアップ手順

### Windows (PowerShell)
```powershell
# Neovimのインストール
scoop install neovim
# または
choco install neovim

# 依存関係
scoop install fd ripgrep
# または  
choco install fd ripgrep

# 設定のクローン
git clone https://github.com/yahihi/config_nvim.git $env:LOCALAPPDATA\nvim
```

### macOS
```bash
# Neovimのインストール
brew install neovim

# 依存関係
brew install fd ripgrep

# 設定のクローン
git clone https://github.com/yahihi/config_nvim.git ~/.config/nvim
```

### Linux/WSL
```bash
# Neovimのインストール
sudo apt install neovim  # Ubuntu/Debian
# または
sudo pacman -S neovim    # Arch

# 依存関係
sudo apt install fd-find ripgrep  # Ubuntu/Debian
# または
sudo pacman -S fd ripgrep        # Arch

# 設定のクローン
git clone https://github.com/yahihi/config_nvim.git ~/.config/nvim
```

## プラットフォーム別の注意事項

### Windows
- Git Bashは非推奨（PowerShellを使用）
- パスの区切り文字は自動的に処理
- 管理者権限は不要

### macOS
- Command Line Toolsが必要
- Homebrewを推奨

### WSL
- Windows側とWSL側でNeovimを分けて管理
- クリップボード共有は`win32yank`を推奨

## トラブルシューティング

### fdコマンドが見つからない
- プラットフォームに応じて適切なパッケージマネージャーでインストール
- find_commandがnilの場合は自動的にVim globにフォールバック

### 文字化け（Windows）
- Windows Terminalの使用を推奨
- フォントをNerdFonts対応に変更