# GitHub Personal Access Token (PAT) の管理方法

## 推奨される管理方法

### 1. Git Credential Manager (推奨)
```bash
# インストール
sudo apt-get install git-credential-manager

# 設定
git config --global credential.helper manager-core

# 初回push時にトークンを入力すると自動保存
git push
```

### 2. git-credential-store（シンプル）
```bash
# 設定（平文で保存されるので注意）
git config --global credential.helper store

# 初回push時に保存される
git push
# Username: yahihi
# Password: <PAT>
```

### 3. キーチェーン統合（より安全）

#### Linux (libsecret)
```bash
# インストール
sudo apt-get install libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make

# 設定
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
```

#### macOS
```bash
git config --global credential.helper osxkeychain
```

### 4. 環境変数（CI/CD向け）
```bash
# .bashrc や .zshrc に追加（ローカルでは非推奨）
export GITHUB_TOKEN="ghp_..."

# 使用時
git clone https://$GITHUB_TOKEN@github.com/yahihi/config_nvim.git
```

## セキュリティのベストプラクティス

1. **最小限の権限**
   - 必要な権限のみ付与（通常は`repo`のみ）

2. **有効期限の設定**
   - 定期的に更新（30日、90日など）

3. **用途別にトークンを分ける**
   - 開発用、CI/CD用、etc.

4. **絶対にしてはいけないこと**
   - コードにハードコード
   - 公開リポジトリにコミット
   - チャットやSNSで共有

## トークンの確認・管理

GitHubで管理：
1. Settings → Developer settings → Personal access tokens
2. 不要なトークンは削除
3. 最終使用日を確認

## トラブルシューティング

### 保存されたトークンをクリア
```bash
# credential.helperの確認
git config --global credential.helper

# キャッシュクリア
git config --global --unset credential.helper
```

### 特定のリポジトリのみ設定
```bash
cd /path/to/repo
git config credential.helper store
```