# README
## アプリケーションの概要
自分の条件に合ったジムを探すことができ、ジムでの体験を口コミで共有できるサービス。  
- [MyGym](https://mygym-app.com/)
## 技術一覧
- AWS EC2/RDSを用いたRails本番環境構築
- EC2上にDockerを展開、Nginxコンテナで受けてRailsコンテナに受け渡し
- AWS ACMでSSL証明書を発行し、SSL化
- 独自ドメインRoute53使用
- CircleCIによる自動ビルド＆テスト&デプロイ
- docker-composeを用いたRails開発環境にて作成
- RSpecにて単体・統合テスト
- RSpecのsystemspecではdocker-seleniumをコンテナで起動
- Ajaxを用いた非同期処理（お気に入り登録/解除、口コミへのいいね、写真などの切り替え表示）
- Bootstrapによるレスポンシブ対応
- slimにて記述

## アプリケーションの機能ポイント
- SNS、Twitter,Facebook,Googleのアカウントを使ったログイン機能
- Twitter,Facebook,Googleのアカウントでログインした際、ユーザー写真をそのまま引き継いて使える
- ジムの詳細では住所にGoogleMapAPIで地図を表示
- 店名、エリア、こだわりタグによる絞り込み検索機能で自分に合ったジムが探せる(N1問題解決済み)
- 口コミには５つ星で評価ができる
- 登録写真はAjaxによりその場で変更確認できる
- ジムのお気に入り登録、Twitter ,Facebookでshare可能
- 口コミに対し役に立つボタンがあり口コミの信頼度がわかる

### 環境
- フレームワーク
 Ruby on Rails 5.2
- インフラ
 AWS EC2, Docker
- データベース
 AWS RDS, Mysql5.7
- アプリケーションサーバー
 Puma
- Webサーバー
 Nginx
