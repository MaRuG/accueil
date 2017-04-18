# Description:
#   Anime RESTful APIから放送中のアニメの情報を取得
#   (http://api.moemoe.tokyo/anime/v1)
#
# Commands:
#   hubot anime/アニメ         - 今期放送中のアニメの一覧を表示
#   hubot anime/アニメ <title> - 今期のアニメをタイトルで検索
#   hubot anime/アニメ <year>  - 指定年のアニメを表示
#
moment = require('moment')
table = require('easy-table')

cour = ->
  year = moment().year()
  month = moment().month()
  if month < 3
    return "/#{year}/1"
  if month < 6
    return "/#{year}/2"
  if month < 9
    return "/#{year}/3"
  return "/#{year}/4"

module.exports = (robot) ->
  ERR_MSG = 'Failure to call Anime RESTful API'
  NiL_MSG = 'No RESULT'

# 今季アニメ情報一覧
  robot.respond /(anime|アニメ)$/i, (msg) ->
    url = "http://api.moemoe.tokyo/anime/v1/master#{cour()}"
    msg.http(url).get() (err, res, body) ->
      if err? or res.statusCode isnt 200
        return msg.reply("#{ERR_MSG}\n```\n#{err}\n```")
      animes = JSON.parse(body)
      t = new table
      for anime in animes
        t.cell('URL', anime.public_url)
        t.cell('Title', anime.title)
        t.newRow()
      if t.rows.length > 0
        return msg.reply('```\n' + t.print().trim() + '\n```')
      msg.reply(NiL_MSG)

# 今季アニメのタイトル
  robot.respond /(anime|アニメ)\s+(.+)$/i, (msg) ->
    url = "http://api.moemoe.tokyo/anime/v1/master#{cour()}"
    keyword = msg.match[1]
    msg.http(url).get() (err, res, body) ->
      if err? or res.statusCode isnt 200
        return msg.reply("#{ERR_MSG}\n```\n#{err}\n```")
      animes = JSON.parse(body)
      pattern = new RegExp(keyword, 'i')
      t = new table
      for anime in animes
        if anime.title.search(pattern) >= 0
          t.cell('URL', anime.public_url)
          t.cell('Title', anime.title)
          t.newRow()
      if t.rows.length > 0
        return msg.reply('```\n' + t.print().trim() + '\n```')
      msg.reply(NiL_MSG)

# 指定年のアニメ一覧
  robot.respond /(anime|アニメ)\s+(\d{4})$/i, (msg) ->
#    msg.send msg.match[2]
    msg.send "http://api.moemoe.tokyo/anime/v1/master/#{msg.match[2]}"
    url = "http://api.moemoe.tokyo/anime/v1/master/#{msg.match[2]}"
    msg.http(url).get() (err, res, body) ->
      if err? or res.statusCode isnt 200
        return msg.reply("#{ERR_MSG}\n```\n#{err}\n```")
      animes = JSON.parse(body)
      t = new table
      for anime in animes
          t.cell('URL', anime.public_url)
          t.cell('Title', anime.title)
          t.newRow()
      if t.rows.length > 0
        return msg.reply('```\n' + t.print().trim() + '\n```')
      msg.reply(NiL_MSG)
