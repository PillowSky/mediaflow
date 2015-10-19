express  = require 'express'
asset = require '../models/asset'

router = express.Router()
router.get '/asset', (req, res, next) ->
	res.json(asset)

module.exports = (app) ->
	app.use '/', router
