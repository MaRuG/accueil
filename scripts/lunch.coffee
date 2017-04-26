# Description
#   A Hubot script for choosing at random
#
# Configuration:
#   None
#
# Commands:
#	lunch -- 昼飯をランダムで返信 
#
# Author:
#  Akira 

cronJob = require('cron').CronJob
random = require('hubot').Response::random


module.exports = (robot) ->

  robot.hear /(lunch)/i, (msg) ->
    lunch = msg.random [
      '一平ソバ'
      '清華'
      'コンビニ'
      'スエヒロ'
      '東館食堂'
      'サクラキッチン'
    ]
    msg.reply "#{lunch}"

# #your_channelと言う部屋に、平日の13:00時に実行
  new cronJob('0 40 12 * * 0-5', () ->
    say = '昼飯の時間ぜよ！' + random [
      '一平ソバ'
      '清華'
      'コンビニ'
      'スエヒロ'
      '東館食堂'
      'サクラキッチン'
    ]
    send '#12th-member', say
  ).start()
  
#  cronjob =new cronJob(
#    cronTime: '0 03 12 * * 0-5',() => 
#    say = '昼飯の時間ぜよ！' + random [
#      "一平ソバ"
#	  "清華"
#      "コンビニ"
#	  "スエヒロ"
#	  "東館食堂"
#	  "サクラキッチン"
#    ]
#    user = {room: '#12th-member'}
#	start: true
#    timeZone: "Asia/Tokyo"
#	onTick: ->
#      robot.send user, say
#  )
