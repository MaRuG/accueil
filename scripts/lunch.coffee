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

module.exports = (robot) ->

  cronjob = new cronJob(
    cronTime: "0 30 8 * * tue"    # 実行時間
    start:    true                # すぐにcronのjobを実行するか
    timeZone: "Asia/Tokyo"        # タイムゾーン指定
    onTick: ->                    # 時間が来た時に実行する処理
      robot.send {room: "#general"}, "今日はハグの日ですよ！"
  )
