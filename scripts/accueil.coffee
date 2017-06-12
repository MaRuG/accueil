# Description:
#
# accueilのgithubページを表示
#
# Commands:
#   hubot github         - accueilbotのGithubページ表示

imodule.exports = (robot) ->

  robot.respond /github$/i, (msg) ->
    msg.send "https://github.com/MaRuG/accueil"
    msg.send "欲しい機能は,GitHubのIssueで教えてね！"
