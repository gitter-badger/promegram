fs = require 'fs'
telegram =
	Bot: require 'node-telegram-bot-api'

init_bot = (token_file_name) ->
	promise = (func) -> (args...) ->
		new Promise (resolve, reject) ->
			try
				resolve func args...
			catch error
				reject error

	create_bot_by_token = promise (token) ->
		new telegram.Bot token, polling: true

	load_token = (token_file_name) ->
		new Promise (resolve, reject) ->
			fs.readFile token_file_name, (err, data) ->
				if err then reject err
				resolve data.toString().trim()

	set_command_listeners = (listeners) -> (bot) ->
		bot.on 'text', (msg) ->
			reply = bot.sendMessage.bind bot, msg.chat.id

			[command, args...] = msg.text.split ' '
			for listener_command, listener of listeners
				if command is listener_command
					return listener reply, args...

			if command.startsWith '/'
				reply '@TODO: show unknown command message'
			else
				reply '@TODO: answer on spam or ignore'

	start_command = (reply) ->
		reply '@TODO: start command'

	register_command = (reply, server, username, password) ->
		reply 'Registering user on ' + server + ' with ' + username + ':' + password
		reply 'I dont share your personal data with anybody'

	command_listeners =
		'/start': start_command
		'/register': register_command

	load_token token_file_name
		.then create_bot_by_token
		.then set_command_listeners command_listeners

init_bot 'bot-key.secret'
