# README

### Dockerを導入したい....!!まじで...!

## はじめに

```
source env.sh
```

を実行すると、各種コマンドの短縮ができる。

```
#サーバー起動
up

#db:migrateする
migrate

#bundle installする
install

そのほかにもコマンドはあるから、env.shを見てね！
```

## 開発の進め方

ブランチを切るときはissueベースで切ろう。

動作確認が不十分なやつはプルリクエスト・マージリクエストを送らないでね。

動作確認が不十分だけどコードレビューをしてほしいときはコミットメッセージの前に「WIP:」をつけよう。

## バージョンなど

* Ruby Version: 2.6.1

* Rails Version: 5.2.3

* CSS Framework: BULMA

* DB: SQLite3

* View: ERB

## データベース構造

### devicesテーブル

モデル名：Device

|カラム名     |カラムの型     |説明                                         |
|------------|-------------|--------------------------------------------|
|id          |integer      |デバイスのID                                  |
|token       |string       |デバイスのトークン（個々のデバイスを識別するもの。   |
|url         |string       |デバイスのURL                                 |

### device_placesテーブル

モデル名：DevicePlace

|カラム名     |カラムの型     |説明                                         |
|------------|-------------|--------------------------------------------|
|id          |integer      |                                            |
|device_id   |integer      |その位置情報が表すデバイスのID                   |
|latitude    |string       |緯度                                         |
|longitude   |string       |経度                                         |

### usersテーブル

モデル名：User

has_one: device_user

|カラム名     |カラムの型     |説明                                         |
|------------|-------------|--------------------------------------------|
|id          |integer      |                                            |
|user_id     |string       |ユーザーが自由に決めるID                        |
|email       |string       |ユーザーのメールアドレス                        |
|password    |string       |ユーザーのパスワード                            |

### device_usersテーブル

モデル名：DeviceUser

belong_to: user

|カラム名     |カラムの型     |説明                                         |
|------------|-------------|--------------------------------------------|
|id          |integer      |                                            |
|device_id   |integer      |デバイスのID                                  |
|user_id     |string       |ユーザーID                                    |
