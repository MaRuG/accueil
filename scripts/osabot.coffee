# Description:
#   osabot
#
# Commands:

fs = require('fs')
props = require('props')
_ = require 'lodash'

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
    str = "#{json.presen.accounts[3]}"
    count = "#{str}".indexOf(",")
    #@taguchiを取得
    #console.log "#{str[0.."#{count-1}"]}"

    if "#{str[0.."#{count-1}"]}" is "#{name}"
      msg.reply('は？')
