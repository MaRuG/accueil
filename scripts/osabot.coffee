# Description:
#   osabot
#
# Commands:

fs = require('fs')
props = require('props')
random = require('hubot').Response::random

module.exports = (robot) ->
  ERR_MSG = 'ここちょっとわからなかったんですけど。。。'
  loadJSON = ->
    try
      json = fs.readFileSync('./data/semi.json', 'utf8')
      return props(json)
    catch err
      return false

  robot.respond /.*/, (msg) ->
    json = loadJSON()
    unless json
      return msg.reply(ERR_MSG)
    name = "#{msg.message.user.name}"
    str = "#{json.presen.accounts[1]}"
    #文字数取得
    #console.log "#{str}".length
    count = "#{str}".indexOf("@taguchi")
    #@taguchiを取得
    #console.log "#{str["#{count}".."#{str}".length-1]}"

    if "#{str["#{count}".."#{str}".length-1]}" is "#{name}"
      word = msg.random [
        'は？'
        'にゅ'
        'bye'
      ]
      msg.reply "#{word}"
