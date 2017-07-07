# accueil

accueilは,hubotで作られたslack上で用いるchatbotです。
機能は以下に記載しています。

[heroku]: http://www.heroku.com
[hubot]: http://hubot.github.com
[generator-hubot]: https://github.com/github/generator-hubot

# Function
* アニメ情報
* githubのissue表示/作成/閉じる
* ランチをランダムで表示と定時に表示
* 卒論の締め切りを表示
* ゼミ情報を表示
* 映画の上映情報を表示
* 電車の遅延情報を定期的に表示

# Command
| command 　　| options | function |
|:------------|:-------:|:--------------------------------------------:|
|anime/アニメ |         | 今期放送中のアニメの一覧を表示               |
|anime/アニメ | title   | 今期ののアニメのタイトルを検索               |
|anime/アニメ | year    | 指定年のアニメを表示                         |
| issue       | list    | githubのissueのリストを表示                  |
| issue       | create <title> body <content>  | githubのissueを作成   |
| issue       | issue close <number>    | githubのissueを閉じる        |
| lunch       | ------- | ランチをランダムで決める& 12:30に定期的に実行|
| thesis      | ------- | 卒論の締め切りまでの日数を表示               | 
| thesis      | bachelor| 学部の卒論締め切りを設定                     | 
| thesis      | master  | 修士の卒論締め切りを設定                     |
|semi         | ------- | 次のゼミ情報を表示                           |
|semi         | list    | ゼミ情報を表示                               |
| theater     | ------- | 登録済みの映画館の上映情報を表示             |
| train       | all     | Yahoo!電車情報を表示                         |

# Now Coding
circle ci + capistrano -> deploy like chatops

# Want Function

