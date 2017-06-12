module.exports = (robot) ->
  robot.respond /かわいい/i, (msg) ->
    msg.send " 目が腐ってんじゃないの？"
  
  robot.hear /ブス|busu|busubot/i, (msg) ->
    msg.send "ブスじゃないし！ #{msg.message.user.name}"
