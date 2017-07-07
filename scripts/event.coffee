# Description
#   atmarkit(https://event.atmarkit.co.jp/)で紹介されている東京都で開かれる参加費無料のイベントを一ヶ月後まで表示
#
# Configuration:
#   None
#
# Commands:
#   hubot event - イベントのジャンルを表示
#   hubot event network - ネットワークのイベントを表示
#   hubot event security - セキュリティのイベントを表示
#   hubot event database - データベースのイベントを表示
#
# Author:
#   kami
#
module.exports = (robot) ->
  request = require 'request-b'
  cheerio = require 'cheerio'

  DateAfterOneMonth = ->
    d = new Date
    month = d.getMonth() + 2
    date = d.getDate()
    str = "#{month}#{date}"
    return parseInt(str, 10)

  RequestEvent = (res, eventname, baseUrl, url) ->
    date = DateAfterOneMonth()
    request(url).then (r) ->
      $ = cheerio.load r.body
      urls = []
      timesChange = []
      $('.queried-events').each ->
        e = $ @
        $('.title a').each ->
          url = baseUrl + $(this).attr('href')
          urls.push url
        title = e.find('.title a').text().trim()
        titles = title.split(/\n/)
        time = e.find('.date').text().trim().replace(/\n/g," ")
        times = time.split(/\s\s\s\s/)
        for i in [0..times.length-1]
          timeChange = parseInt("#{times[i]}"[5..6] + "#{times[i]}"[8..9], 10)
          timesChange.push timeChange if date >= timeChange
        res.send "#{eventname}"
        res.send "#{times[i]} : #{titles[i]}\n#{urls[i]}\n" for i in [0..timesChange.length-1]

  robot.respond /(event|イベント)$/i, (res) ->
    network = "ネットワーク：event network"
    security = "セキュリティ：event security"
    database = "データベース：event database"
    res.send "次から興味あるイベントを選んで右側のコマンドを入力してね♡\n#{network}\n#{security}\n#{database}"

  robot.respond /(event|イベント)\s+(network|ネットワーク)$/i, (res) ->
    eventname = "東京都で行われる無料のネットワークのイベント一覧"
    baseUrl = 'http://event.atmarkit.co.jp'
    url = "#{baseUrl}/events/filtered?utf8=%E2%9C%93&q%5Bkeywords%5D=&q%5Bterm_first%5D=&q%5Bterm_last%5D=&q%5Binclude_ended%5D=0&q%5Bprefectures%5D=13&q%5Bprice_range%5D=%E7%84%A1%E6%96%99&q%5Bhas_report_only%5D=0&commit=%E3%81%93%E3%81%AE%E6%9D%A1%E4%BB%B6%E3%81%A7%E6%A4%9C%E7%B4%A2&q%5Bgenres%5D%5B%5D=14"
    RequestEvent res, eventname, baseUrl, url

  robot.respond /(event|イベント)\s+(security|セキュリティ)$/i, (res) ->
    eventname = "東京都で行われる無料のセキュリティのイベント一覧"
    baseUrl = 'http://event.atmarkit.co.jp'
    url = "#{baseUrl}/events/filtered?utf8=%E2%9C%93&q%5Bkeywords%5D=&q%5Bterm_first%5D=&q%5Bterm_last%5D=&q%5Binclude_ended%5D=0&q%5Bprefectures%5D=13&q%5Bprice_range%5D=%E7%84%A1%E6%96%99&q%5Bhas_report_only%5D=0&commit=%E3%81%93%E3%81%AE%E6%9D%A1%E4%BB%B6%E3%81%A7%E6%A4%9C%E7%B4%A2&q%5Bgenres%5D%5B%5D=6"
    RequestEvent res, eventname, baseUrl, url

  robot.respond /(event|イベント)\s+(database|データベース)$/i, (res) ->
    eventname = "東京都で行われる無料のデータベースのイベント一覧"
    baseUrl = 'http://event.atmarkit.co.jp'
    url = "#{baseUrl}/events/filtered?utf8=%E2%9C%93&q%5Bkeywords%5D=&q%5Bterm_first%5D=&q%5Bterm_last%5D=&q%5Binclude_ended%5D=0&q%5Bprefectures%5D=13&q%5Bprice_range%5D=%E7%84%A1%E6%96%99&q%5Bhas_report_only%5D=0&commit=%E3%81%93%E3%81%AE%E6%9D%A1%E4%BB%B6%E3%81%A7%E6%A4%9C%E7%B4%A2&q%5Bgenres%5D%5B%5D=3"
    RequestEvent res, eventname, baseUrl, url
