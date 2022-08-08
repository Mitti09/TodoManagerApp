# TodoManagerApp


<img src= "https://user-images.githubusercontent.com/95211952/183408067-e4abd3b9-711e-463d-93e9-49b681d07379.png" width= "300">　　
<img src= "https://user-images.githubusercontent.com/95211952/183408076-cfa38bd3-56bb-4f6e-9cf9-882279712a2a.png" width= "300">



 画像。画面のスクリーンショットを2枚はる。

# リポジトリ名

このアプリは、シンプルにタスクを管理できるTodoアプリです。
タスクには、日時を設定することができ、メイン画面では
ユーザーが選択した日付に該当するタスクを表示させることができます。

また、widget機能も設定されており
ホーム画面から今日のタスクを確認することができます。

# Dependency
Xcode 
Version 13.4.1

SwiftUI 
CoreData
WidgetKit

Pods 
FSCalendar

# Usage
ContentViewの画面右下部分にある、trayボタンからタスクを新規作成することができます。
新規作成が完了しましたらAllTaskViewに反映され、タスク一覧に追加されます。

作成したタスクをタップすることで新規作成時に時間を未設定に設定していても、タスク名を変更したり
再度時間を設定することも可能となっています。

ContentViewでは、作成したタスクを基に
・ユーザーが選択した日のタスク
・今日のタスク

を表示させるviewを用意しています。

widgetに関しては、medinumサイズのwidgetを用意しています。
ここでは
・今日の日付、曜日
・今日のタスク

を表示させ、アプリを開かずともタスクを確認することが可能となっています。

## Authors
Michitaka Ishida

