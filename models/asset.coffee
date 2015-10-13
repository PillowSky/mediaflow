fs = require 'fs'
path = require 'path'
child_process = require 'child_process'

assetDirectory = path.join(__dirname, '../public/assets')
categoryList = fs.readdirSync(assetDirectory)

# item in category

asset = {}

for category in categoryList
	categoryPath = path.join(assetDirectory, category)
	if fs.statSync(categoryPath).isDirectory()
		asset[category] = {}
		fileList = fs.readdirSync(categoryPath)
		for filename in fileList
			extname = path.extname(filename)
			realname = path.basename(filename, extname)
			asset[category][realname] = {} unless asset[category][realname]

			switch extname.toLowerCase()
				when '.jpg', '.jpeg', '.tif', '.bmp'
					absname = path.join(categoryPath, filename).replace("'", "\'")
					newname = absname.replace(extname, '.png')
					try
						cmd = "convert '#{absname}' '#{newname}'"
						child_process.execSync(cmd)
						asset[category][realname].image = filename.replace(extname, '.png')
						fs.unlink(absname)
					catch e
						console.log(e)
						fs.unlink(absname)
						fs.unlink(absname.replace(extname, '.m4a'))
						fs.unlink(absname.replace(extname, '.txt'))
				when '.png' then asset[category][realname].image = filename
				when '.m4a' then asset[category][realname].audio = filename
				when '.txt' then asset[category][realname].text = filename

module.exports = asset
