# Description
#   A Hubot script managing Github issues
#   You need acquire a token first:
#	  $ curl -u 'username' -d '{"scopes":["repo"],"note":"Help example"}'  https://api.github.com/authorizations
#     $ export HUBOT_GITHUB_TOEKN=token_value
#
# Commands:
#   hubot issue list - list up issues
#   hubot issue create <title> body <content>  - create an issue with a body
#   hubot issue close <number> - close an issue
# Author:
#   Ak1ra

repo  = "username/repository"

module.exports = (robot) ->
  github = require('githubot')(robot)

  robot.respond /issue list/i, (msg) ->
    github.get "https://api.github.com/repos/#{repo}/issues", {}, (issues) ->
      issues = issues.sort (a,b) -> a.number > b.number
      texts = ["https://github.com/#{repo}/issues"]
      for i in issues
        texts.push "[#{i.number}] #{i.title}"
      text = texts.join '\n'
      msg.reply "I'm listing up your issues\n#{text}"

  robot.respond /issue create (.+) body (.+))/i, (msg) ->
    who = msg.message.user.name
    title= msg.match[1]
    body = msg.match[3]
    if body is undefined then body = ""
    query_param =
      title: title
      body: "#{title}\n\ncreated by #{who} & hubot\n\n#{body}"
      labels: ["fromHubot"]
    github.post "https://api.github.com/repos/#{repo}/issues", query_param, (issue) ->
      text = "Sure! I created an issue for you\n#{issue.html_url}"
      msg.reply text

  robot.respond /issue close (.*)/i, (msg) ->
    github.patch "/repos/#{repo}/issues/#{msg.match[1]}", {state: "closed"}, (issue, error) ->
      if error then console.log error
      text = "OK. I closed #{issue.title} issue"
msg.reply text
