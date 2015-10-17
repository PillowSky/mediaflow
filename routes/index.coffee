express = require 'express'
asset = require '../models/asset'

router = express.Router()

router.get '/', (req, res) ->
	res.render 'index'

router.get '/asset', (req, res) ->
	res.json(asset)

module.exports = router
