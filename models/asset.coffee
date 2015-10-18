fs = require 'fs'
path = require 'path'

assetDirectory = path.join(__dirname, '../public/assets')
category = fs.readdirSync(assetDirectory)

# item in category

asset = {}

for folder in category
	dir = path.join(assetDirectory, folder)
	if fs.statSync(dir).isDirectory()
		asset[folder] = {}
		files = fs.readdirSync(dir)
		for file in files
			extname = path.extname(file)
			realname = path.basename(file, extname)
			asset[folder][realname] = {} unless asset[folder][realname]?
			switch extname.toLowerCase()
				when '.jpg' then asset[folder][realname].image = file
				when '.m4a' then asset[folder][realname].audio = file
				when '.txt' then asset[folder][realname].text = file

module.exports = asset
