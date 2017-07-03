#dcription
#   A Hubot script that display the latest news in yahoo news feed.
#
# Dependencies:
#   None
#
# Configuration:
#   "hubot-arm": "git://github.com/bouzuya/hubot-arm",
#   "hubot-request-arm": "git://github.com/bouzuya/hubot-request-arm",
#   "moment": "^2.8.2",
#   "xml2js": "^0.4.4"
#
# Commands:
#   hubot yahoo-now - display the latest news in yahoo news feed.
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  require('hubot-arm') robot
  {parseString} = require 'xml2js'
  moment = require 'moment'

  robot.respond /news$/i, (res) ->
    count = 0
    res.send "最新のニュース5件だお♡"
    res.robot.arm('request')
      url: 'http://news.yahoo.co.jp/byline/rss/all.xml'
    .then (r) ->
      parseString r.body, (err, parsed) ->
        message = parsed.rss.channel[0].item
          .map (i) ->
            title: i.title[0]
            link: i.link[0]
            pubDate: moment(i.pubDate[0])
          .map (i) ->
            if '\n'? then count++
            "#{i.pubDate.format()} : #{i.title} : #{i.link}" if count < 6
          .join '\n'
        res.send message.trim()
    , (e) ->
      robot.logger.error e
      res.send 'news: error'
