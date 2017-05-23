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


  new cronJob('0 10 13 * * 1-5', () ->
    
    messages =  [
      '一平ソバ'
      '清華'
      'コンビニ'
      'スエヒロ'
      '東館食堂'
      'サクラキッチン'
    ]

    message = messages[Math.floor(Math.random() * messages.length)]
    
    robot.send( '#12th-member', message)
  ).start

#  new cronJob('0 30 20 * * 1-5', () ->
#    send '#12th-member', "@here テストなので無視でよろ"
#  ).start()

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
