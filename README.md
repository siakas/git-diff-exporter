# Git Diff Exporter

このリポジトリでは、Git のコミット間の差分ファイルを抽出するスクリプトを提供しています。Ruby と Python の 2 つのバージョンがあります。

## 事前準備

1. まず、スクリプトをリポジトリのルートディレクトリに保存します。

   Ruby 版: `git_diff_exporter.rb`

   Python 版: `git_diff_exporter.py`

2. ターミナルを開き、スクリプトが保存されたディレクトリに移動します。

3. スクリプトに実行権限を付与します。

   Ruby 版:

   ```
   chmod +x git_diff_exporter.rb
   ```

   Python 版:

   ```
   chmod +x git_diff_exporter.py
   ```

## スクリプトの実行方法

ターミナルを開き、以下のコマンドを実行してください（`<OLDER_COMMIT>` と `<NEWER_COMMIT>` を適切なコミットハッシュに置き換えてください）。

Ruby 版:

```
./git_diff_exporter.rb <OLDER_COMMIT> <NEWER_COMMIT>
```

Python 版:

```
./git_diff_exporter.py <OLDER_COMMIT> <NEWER_COMMIT>
```

## SourceTree のカスタムアクションとして利用する方法

1. SourceTree を開き、メニューバーの「SourceTree」>「環境設定」をクリックします。

2. 「カスタムアクション」タブをクリックし、「追加」ボタンをクリックします。

3. 「メニューキャプション」に任意の名前を入力します（例：`Export Git Diff`）。

4. 「スクリプト」欄に、保存したスクリプトへのフルパスを入力します。

   Ruby 版: `/path/to/your/repository/git_diff_exporter.rb`

   Python 版: `/path/to/your/repository/git_diff_exporter.py`

5. 「パラメータ」欄に、`$SHA` を入力します。

6. 「OK」をクリックして、カスタムアクションを保存します。

7. コミットログを右クリックし、コンテキストメニューから先ほど作成したカスタムアクションを選択して実行します。これにより、選択されたコミット間の差分ファイルが抽出されます。
