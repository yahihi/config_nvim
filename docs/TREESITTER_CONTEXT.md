# Treesitter Context の使い方

## 機能
スクロール時に現在のコンテキスト（関数名、クラス名、メソッド名など）を画面上部に固定表示します。

## 自動的に表示される内容
- 関数定義
- クラス定義
- メソッド定義
- if文やループなどのブロック
- その他の構造的要素

## キーマップ
- `[c` - 現在のコンテキスト（関数の開始位置など）にジャンプ

## コマンド
- `:TSContextEnable` - 有効化
- `:TSContextDisable` - 無効化
- `:TSContextToggle` - トグル

## 設定内容
- 最大3行まで表示
- 行番号も表示
- カーソル位置を基準に計算

## 例
```python
class MyClass:
    def very_long_method(self):
        # 100行以上のコード...
        # スクロールしても上部に "class MyClass:" と
        # "def very_long_method(self):" が表示される
        pass
```