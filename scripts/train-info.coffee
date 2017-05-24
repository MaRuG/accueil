# Description:
#   電車遅延情報をSlackに投稿する
#
# Commands:
#   hubot train < maeda | all > - Return train info
#
# crontimeによって, 6~23の4時間毎に,遅延情報
#

cheerio = require 'cheerio-httpcli'
cronJob = require('cron').CronJob

module.exports = (robot) ->

  ROOM = "#12th-member"

  searchAllTrain = (msg) ->
    # send HTTP request
    baseUrl = 'http://transit.loco.yahoo.co.jp/traininfo/gc/13/'
    cheerio.fetch baseUrl, (err, $, res) ->
      if $('.elmTblLstLine.trouble').find('a').length == 0
        msg.send "事故や遅延情報はありません"
        return
      $('.elmTblLstLine.trouble a').each ->
        url = $(this).attr('href')
        cheerio.fetch url, (err, $, res) ->
          title = "◎ #{$('h1').text()} #{$('.subText').text()}"
          result = ""
          $('.trouble').each ->
            trouble = $(this).text().trim()
            result += "- " + trouble + "\r\n"
          msg.send "#{title}\r\n#{result}"

  # robot.respond /train (.+)/i, (msg) ->
  #   target = msg.match[1]
  #   # 京浜東北線
  #   jr_kt = 'http://transit.yahoo.co.jp/traininfo/detail/22/0/'
  #   # 山手線
  #   jr_ym = 'http://transit.yahoo.co.jp/traininfo/detail/21/0/'
  #   # 埼京線
  #   jr_sk = 'http://transit.yahoo.co.jp/traininfo/detail/50/0/'
  #   # 湘南新宿ライン
  #   jr_ss = 'http://transit.yahoo.co.jp/traininfo/detail/25/0/'
  #   # 中央線
  #   jr_chu = 'http://transit.yahoo.co.jp/traininfo/detail/38/0/'
  #
  #   if target == "akira"
  #     searchTrain(jr_ym, msg)
  #     searchTrain(jr_kt, msg)
  #     searchTrain(jr_chu, msg)
  #   else if target == "all"
  #     searchAllTrain(msg)
  #   else
  #     msg.send "#{target}は検索できないよ。Σ (￣ロ￣|||)"

  # searchTrain = (url,msg) ->
  #   cheerio.fetch url, (err, $, res) ->
  #     title = "#{$('h1').text()}"
  #     if $('.icnNormalLarge').length
  #       msg.send "#{title}は遅れてないですね。はい"
  #     else
  #       info = $('.trouble p').text()
  #       msg.send "#{title}は遅れている。zamaaaaaaaaaaaaaaaa! \n#{info}"

  new cronJob('0 0 6-23/4 * * 1-5', () ->
    # 中央線
    jr_chu = 'http://transit.yahoo.co.jp/traininfo/detail/38/0/'
    # 京浜東北線
    jr_kt = 'http://transit.yahoo.co.jp/traininfo/detail/22/0/'
    # 山手線
    jr_ym = 'http://transit.yahoo.co.jp/traininfo/detail/21/0/'
    #searchTrainCron(jr_chu)
    #searchTrainCron(jr_kt)
    #searchTrainCron(jr_ym)
    str = searchTrainCron(jr_chu) + "\n" + searchTrainCron(jr_kt) + "\n" + searchTrainCron(jr_ym)
    robot.send( '#12th-member', str)
  ).start()

  searchTrainCron = (url) ->
    cheerio.fetch url, (err, $, res) ->
      title = "#{$('h1').text()}"
      if $('.icnNormalLarge').length
        robot.send {room: '#12th-member'}, "#{title}は遅れてないよ。はい。"
      else
        info = $('.trouble p').text()
        robot.send {room: '#12th-member'}, "#{title}は遅れているみたい。\n#{info}"
