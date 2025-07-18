# Fish ShellでOpenAI APIキーを設定する方法

## 1. 一時的に設定（現在のセッションのみ）
```fish
set -x OPENAI_API_KEY "sk-..."
```

## 2. 永続的に設定（推奨）

### 方法A: config.fishに追加
```fish
# ~/.config/fish/config.fish を編集
echo 'set -x OPENAI_API_KEY "sk-..."' >> ~/.config/fish/config.fish
```

### 方法B: 専用ファイルを作成（よりセキュア）
```fish
# APIキー用の設定ファイルを作成
echo 'set -x OPENAI_API_KEY "sk-..."' > ~/.config/fish/conf.d/openai.fish

# パーミッションを制限
chmod 600 ~/.config/fish/conf.d/openai.fish
```

## 3. 設定の確認
```fish
# 環境変数が設定されているか確認
echo $OPENAI_API_KEY

# Neovim内で確認
nvim -c "echo \$OPENAI_API_KEY" -c "q"
```

## 4. 設定の削除
```fish
# 一時的に削除
set -e OPENAI_API_KEY

# 永続的に削除
# config.fishまたはconf.d/openai.fishから該当行を削除
```

## セキュリティのヒント
- APIキーをGitにコミットしないよう注意
- `.gitignore`に以下を追加:
  ```
  **/conf.d/openai.fish
  .env
  ```