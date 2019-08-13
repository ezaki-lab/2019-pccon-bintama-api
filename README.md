# README

### Dockerを導入したい....!!まじで...!

ブランチを切るときはissueベースで切ろう。

動作確認が不十分なやつはプルリクエスト・マージリクエストを送らないでね。

動作確認が不十分だけどコードレビューをしてほしいときはコミットメッセージの前に「WIP:」をつけよう。

# データベース構造

### deviceテーブル

モデル名：Device

|カラム名     |カラムの型     |説明                                         |
|------------|-------------|--------------------------------------------|
|id          |integer      |デバイスのID                                  |
|token       |string       |デバイスのトークン（個々のデバイスを識別するもの。   |
|pass        |string       |デバイスのパスワード。DBにはハッシュ化したものを格納 |
|url         |string       |デバイスのURL                                 |

### device_placeテーブル

モデル名：DevicePlace

|カラム名     |カラムの型     |説明                                         |
|------------|-------------|--------------------------------------------|
|id          |integer      |                                            |
|device_id   |integer      |その位置情報が表すデバイスのID                   |
|latitude    |string       |緯度                                         |
|longitude   |string       |経度                                         |

### userテーブル

モデル名：User

has_one: device_user

|カラム名     |カラムの型     |説明                                         |
|------------|-------------|--------------------------------------------|
|id          |integer      |                                            |
|user_id     |string       |ユーザーが自由に決めるID                        |
|email       |string       |ユーザーのメールアドレス                        |
|pass        |string       |ユーザーのパスワード                            |

### device_userテーブル

モデル名：DeviceUser

belong_to: user

|カラム名     |カラムの型     |説明                                         |
|------------|-------------|--------------------------------------------|
|id          |integer      |                                            |
|device_id   |integer      |デバイスのID                                  |
|user_id     |string       |ユーザーID                                    |
