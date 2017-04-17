# Description:
#   卒業論文・修士論文の締切を通知
#
# Commands:
#   hubot thesis - 締切までの日数を表示
#   hubot thesis bachelor <YYYY/MM/DD> - 卒論の締切を設定
#   hubot thesis master <YYYY/MM/DD> - 卒論の締切を設定
#
# Configuration:
#   HUBOT_THESIS_ROOMS: 締切を通知する部屋

cron = require('cron').CronJob
moment = require 'moment'
moment.locale 'ja'

module.exports = (robot) ->
  THESIS = ['bachelor', 'master']
  THESIS_JP = { bachelor: '卒論', master: '修論' }

  say = (room, message) ->
    envelope = room: room
    robot.send envelope, message

  dead_line = ->
    brain = robot.brain
    return false unless brain.data.thesis

    str = []
    today = moment()
    for key in THESIS
      date = brain.data.thesis[key]
      if date
        days = parseInt (moment(date, 'YYYY/MM/DD') - today) / 86400000
        str.push "#{THESIS_JP[key]}の締切まで #{days} 日"
    return str.join('、') + 'です' + '進捗はどうなんですかね～～？？'

  robot.respond /thesis$/i, (msg) ->
    str = dead_line()
    msg.reply str if str
    msg.reply '締切が設定されていません' unless str

  robot.respond /thesis\s+([a-z]+)\s+([0-9\/]+)$/i, (msg) ->
    key = msg.match[1]
    return unless key in THESIS
    date = msg.match[2]
    return unless date

    brain = robot.brain
    brain.data.thesis = {} unless brain.data.thesis
    brain.data.thesis[key] = date
    brain.save

    msg.reply "#{THESIS_JP[key]}の締切を #{date} に設定しました"

  new cron '0 0 10 * * *', ->
    rooms = process.env.HUBOT_THESIS_ROOMS
    return unless rooms
    str = dead_line()
    return unless str
    for room in rooms.split(',')
      say room, str
  , null, true, 'Asia/Tokyo'
