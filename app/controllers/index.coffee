express  = require 'express'

router = express.Router()
router.get '/', (req, res, next) ->
	res.render 'index'

module.exports = (app) ->
	app.use '/', router
