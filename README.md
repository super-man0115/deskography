# Deskography(デスコグラフィー)
![logo](https://github.com/super-man0115/deskography/assets/66407238/1d60f009-1200-437b-ba07-427899383fc9)
<br>
Desk(机)とgraphy(表現する)を組み合わせた造語です
<br>
https://deskographyapp.com
<br>

## ■ サービス概要

  自分の自慢のデスクを紹介したい人や、デスク環境を整えたいと思っている人に
  自慢のデスク周りや周辺機器を紹介したり、他のユーザーのガジェット等を参考にできる
  デスク周辺ガジェット投稿アプリです
<br>
  ![top](https://github.com/super-man0115/deskography/assets/66407238/4ae92388-9d73-4d85-90ae-244b82c67c64)
<br>

## ■ 使用方法

###  ログイン画面
![login](https://github.com/super-man0115/deskography/assets/66407238/19c5a5ae-a84d-463b-bb85-845bc5a4b849)

ゲストログインで使用することができます。
  
###  ガジェット登録
![item](https://github.com/super-man0115/deskography/assets/66407238/4811f72c-775a-4ee2-8ae3-71b5bed8b82b)
楽天の商品検索apiを使用しています。


  
###  画像登録
![image](https://github.com/super-man0115/deskography/assets/66407238/9b002400-c720-4cca-9d15-2f0f37c9c8df)

ActiveStorageを使用した画像アップロードを行なっています。stimulusを使用して画像のプレビュー機能も実装しました。
削除ボタンを押した画像は投稿には反映されませんがDBには残ってしまうのでwheneverを使用して定期的に削除を実行しています。

### 詳細画面
![show](https://github.com/super-man0115/deskography/assets/66407238/d3aa935c-4e39-4c79-a72d-9c487b84f980)
stimulusを使用したスライドショー、詳細画面ではカルーセル対応にしました。

## ■ 使用技術

  ####  フロントエンド
  - HotWire(turbo + stimulus)
  ![hotwire](https://github.com/super-man0115/deskography/assets/66407238/88f67eeb-d56b-41c0-b73f-540d892ba053)
  - tailwind
 ![tailwind](https://github.com/super-man0115/deskography/assets/66407238/a63c0d7d-c77a-432c-85af-1f733b9d16d2)

  
 <br>
 
 #### バックエンド
 - Ruby 3.2.0
 - rails 7.0.4
   - sorcery(ユーザー認証)
   - kaminari(ページネーション)
   - ransack(検索機能)
   - meta-tags(タグ設定)
   - faraday(HTTPリクエスト)
   - mini_magick(画像加工)
   - config(定数の管理)
   - rails-i18n(日本語化)
   - enum-help(enumの日本語化)
   - dotenv(環境変数の管理)
   - whenever(定時処理)
  
 #### API
 - rakuten_web_service(外部API)
 ![rakuten](https://github.com/super-man0115/deskography/assets/66407238/c26006ee-68a3-48e9-8829-63cf93798478)

## ■画面遷移図
  https://www.figma.com/file/ZWMBhwyMumv6NCQCDmyUfe/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0%3A1&t=h8bY8tmt6niuzlKe-1

## ■ER図
  https://drive.google.com/file/d/14bUxkReF_exWX7NGB8sBcWOSQVJqATix/view?usp=sharing
