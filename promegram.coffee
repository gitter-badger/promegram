fs = require 'fs'
telegram =
	Bot: require 'node-telegram-bot-api'

promise = (func) -> (args...) ->
	new Promise (resolve, reject) ->
		try
			resolve func args...
		catch error
			reject error

init_bot = promise (token) ->
	new telegram.Bot token, polling: true

load_token = (token_file_name) ->
	new Promise (resolve, reject) ->
		fs.readFile token_file_name, (err, data) ->
			if err then reject err
			resolve data.toString().trim()

load_token 'bot-key.secret'
	.then (token) => init_bot token
	.then (bot) => console.log bot
