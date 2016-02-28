'use strict'

asset = require '../models/asset'

module.exports = (app) ->
	app.get '/asset', (req, res) ->
		res.json(asset)
