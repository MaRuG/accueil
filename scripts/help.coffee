# Description:
#	Hubotのコマンド一覧出力
# Command:
#	hubot help	-- コマンド一覧

table = require('easy-table')

module.exports = (robot) ->
	NIL_MSG = "No RESULT"

	robot.respond /help$/i, (msg) ->
		cmds = robot.helpCommands()
		filter = msg.match[1]
		if filter
			cmds = for cmd in cmds
				continue unless cmd.match(new RegExp(filter, 'i'))
				cmd
			if cmd.length is 0
				return msg.reply(NIL_MSG)
		t = new table
		for cmd in cmds
			cmd = cmd.replace(/^hubot/i, robot.name.toLowerCase())
			array = cmd.split(' - ')
			t.cell('Command', array[0])
			t.cell('Description', array[1])
			t.newRow()
		if t.rows.length > 0
			return msg.reply('````\n' + t.print().trim() + '\n````')
		msg.reply(NIL_MSG)
