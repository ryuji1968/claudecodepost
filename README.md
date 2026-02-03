# Sample Rails

Rails 8.1 + MySQL 8.4 を使用した CRUD アプリケーションのサンプルプロジェクトです。

## 特徴

- **フレームワーク**: Rails 8.1, Ruby 3.3
- **データベース**: MySQL 8.4 (utf8mb4)
- **フロントエンド**: Hotwire (Turbo + Stimulus), Bootstrap 5.3
- **アセット**: Propshaft + dartsass-rails, importmap-rails (Node.js 不要)
- **UIテーマ**: カスタム "Materially" テーマ（サイドバーレイアウト、Poppins フォント）
- **チャート**: ApexCharts
- **国際化**: 日本語デフォルト (rails-i18n)
- **ページネーション**: Pagy

## 必要環境

- Docker
- Docker Compose

## セットアップ

```bash
# リポジトリをクローン
git clone https://github.com/ryuji1968/claudecodepost.git
cd claudecodepost

# コンテナをビルド・起動
docker compose up -d

# データベースを作成・マイグレーション
docker compose run --rm web rails db:create db:migrate

# ブラウザで開く
open http://localhost:3000
```

## 開発コマンド

```bash
# サービス起動/停止
docker compose up -d
docker compose down

# Rails コンソール
docker compose run --rm web rails console

# マイグレーション実行
docker compose run --rm web rails db:migrate

# scaffold 生成
docker compose run --rm web rails g scaffold ModelName field:type

# SCSS ビルド（スタイル変更後）
docker compose run --rm web rails dartsass:build

# テスト実行
docker compose run --rm web rails test
docker compose run --rm web rails test test/controllers/posts_controller_test.rb
docker compose run --rm web rails test test/controllers/posts_controller_test.rb:10

# Lint / セキュリティスキャン
docker compose run --rm web bin/rubocop
docker compose run --rm web bin/brakeman
```

## アプリケーション構成

| パス | 説明 |
|------|------|
| `/` | ダッシュボード（投稿統計・グラフ表示） |
| `/posts` | 投稿一覧・CRUD |
| `/up` | ヘルスチェック |

## 技術スタック

| カテゴリ | 技術 |
|----------|------|
| Web フレームワーク | Rails 8.1 |
| データベース | MySQL 8.4 |
| Web サーバー | Puma |
| CSS フレームワーク | Bootstrap 5.3 |
| CSS プリプロセッサ | Dart Sass |
| JavaScript | Stimulus, Turbo |
| チャート | ApexCharts |
| コンテナ | Docker |
| デプロイ | Kamal |
| CI | GitHub Actions |

## ライセンス

MIT
