# はじめに

この文章では[mdBook]で日本語の技術文書を書くためのテンプレート[mdbook-ja-template]について説明します。
このテンプレートを使うことで、 Markdownの文書をHTMLに変換し、ウェブサイトとして公開できます。

## 特徴

mdbook-ja-templateの特徴を説明します。

### すぐに執筆・発信できる

文書執筆に必要なツール一式がDockerコンテナ化されているため、面倒なセットアップ作業は不要です。
すぐに執筆を始めることができます。

文書公開のために必要な作業がGitHub Actionsのワークフローとして定義されており、自動的に実行されます。
余計な手間をかけることなく、作成した文章をすぐに発信できます。

### 文書校正が自動で行われる

文章校正ツール[textlint]が導入されているため、文書の自動校正が可能です。
初期状態で技術文書向けの校正ルールが設定されていますが、自分好みになるようカスタマイズ可能です。

Markdownのスタイルチェックツール[markdownlint]も導入されているため、Markdownの自動スタイルチェックも可能です。

### コマンドを覚えなくても使える

執筆時の典型的なタスクは`Makefile`で簡単に実行できるよう設定されているため、複雑なコマンドを覚える必要はありません。

## コントリビューション

mdbook-ja-templateはオープンソースプロジェクトで、ソースコードは[GitHub]上で公開されています。
問題の報告や機能追加の要望は[GitHubのIssueトラッカー]に投稿してください。

## ライセンス

mdbook-ja-templateは[Creative Commons Zero v1.0 Universal]ライセンスで配布されています。

[mdBook]: https://github.com/rust-lang/mdBook
[mdbook-ja-template]: https://github.com/gifnksm/mdbook-ja-template
[textlint]: https://textlint.github.io/
[markdownlint]: https://github.com/DavidAnson/markdownlint
[GitHub]: https://github.com/gifnksm/mdbook-ja-template
[GitHubのIssueトラッカー]: https://github.com/gifnksm/mdbook-ja-template/issues
[Creative Commons Zero v1.0 Universal]: https://creativecommons.org/publicdomain/zero/1.0/