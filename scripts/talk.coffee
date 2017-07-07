module.exports = (robot) ->
  robot.respond /かわいい/i, (msg) ->
    msg.send " 目が腐ってんじゃないの？"
  
  robot.hear /ぶす|ブス|busu|busubot/i, (msg) ->
    msg.send "ブスじゃないし！ @#{msg.message.user.name}"

  robot.hear /大好きだ！/i, (msg) ->
    msg.send "冴えない@#{msg.message.user.name}の育て方"
