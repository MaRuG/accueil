# Description
#   It is osabotttttttttttt!!!
#
# Configuration:
#   None
#
# Commands:
#   好きな言葉どうぞ。適当な言葉に対応して返信

module.exports = (robot) ->

  robot.respond /(.*)/i, (msg) ->
    
    lang = [
      'は？'
      'にゅ'
      'bye'
      'やめてってInteger'
      'iwmtさんだって触られるの嫌でしょ'
      'knkさんだってどうせ私の事なんか期待してないでしょ'
      'Goodbye Men!!'
    ]

    speak = msg.match[1]

    if speak == "#{lang[0]}"
      i = 1
      msg.reply "#{lang[i]}"

    else if speak == "#{lang[1]}"
      i = 2
      msg.reply "#{lang[i]}"

    else if speak == "#{lang[2]}"
      i = 3
      msg.reply "#{lang[i]}"

    else if speak == "#{lang[3]}"
      i = 4
      msg.reply "#{lang[i]}"

    else if speak == "#{lang[4]}"
      i = 5
      msg.reply "#{lang[i]}"

    else if speak == "#{lang[5]}"
      i = 6
      msg.reply "#{lang[i]}"

    else
      i = 0
      #result = /speak/.test(msg.reply)
      #if result == false
      msg.reply "#{lang[i]}"

