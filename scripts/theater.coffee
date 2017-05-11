# Description
#   A Hubot script that DESCRIPTION
#
# Configuration:
#   None
#
# Commands:
#   hubot theater - DESCRIPTION
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  request = require 'request-b'
  cheerio = require 'cheerio'
  {Promise} = require 'es6-promise'
  table = require 'text-table'
  eaw = require 'eastasianwidth'

  THEATER_IDS = JSON.parse(process.env.HUBOT_THEATER_IDS ? '["11652","11610", "11625"]')

  robot.respond /theater$/i, (res) ->
    THEATER_IDS.reduce(((promise, theaterId) ->
      promise.then (result) ->
        baseUrl = 'http://movies.yahoo.co.jp'
        url = "#{baseUrl}/theater/#{theaterId}/"
        request(url).then (r) ->
          $ = cheerio.load r.body
          movies = []
          theater = $('h1').text().trim()
          $('#schedule_list .listview__element').each ->
            e = $ @
            title = e.find('h3 a').text().trim()
            url = baseUrl + e.find('h3 a').attr('href')
            times = []
            e.find('ul.list-inline li').each ->
              l = $ @
              time = l.find('.btn-schedule').contents().filter(->
                @type is 'text'
              ).text().trim()
              times.push time
            movies.push { title, url, times }
          result.push { theater, movies }
          result
    ), Promise.resolve([])).then (theaters) ->
      message = table(theaters.reduce(((rows, i) ->
        rows.concat(
          [
            [i.theater]
          ].concat(i.movies.map((j) -> ['', j.title].concat j.times)))
      ), []), { stringLength: (c) -> eaw.length(c) })
      res.send message
