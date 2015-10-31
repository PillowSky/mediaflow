'''
Assets KeywordCrawler
by Yuzo (Huang Yuzhong)
Oct 25, 2015

Automatically download assets by keyword
Assets are download from douban FM
'''

fs = require 'fs'
path = require 'path'
request = require 'request'
cheerio = require 'cheerio'

if process.argv.length != 3
	console.error("Usage: #{process.argv[0]} #{process.argv[1]} <config.json>...")
	process.exit(1)

config = JSON.parse(fs.readFileSync(process.argv[2]))
indexUrl = 'http://douban.fm'
playlistUrl = 'http://douban.fm/j/mine/playlist'
albumUrl = 'http://music.douban.com'
assetsDirectory = 'public/assets'

fs.mkdirSync(assetsDirectory) unless fs.existsSync(assetsDirectory)

indexOption =
	url: indexUrl
	followRedirect: false

request indexOption, (error, response, body)->
	leftToken = 'window.hot_channels_json = ['
	rightToken = ';'
	leftIndex = body.indexOf(leftToken) + leftToken.length - 1
	rightIndex = body.indexOf(rightToken, leftIndex)
	hotChannels = JSON.parse(body[leftIndex...rightIndex])

	hotChannels.forEach (channel)->
		if config[channel.name]
			channelDirectory = "#{assetsDirectory}/#{channel.name}"

			if not fs.existsSync(channelDirectory)
				fs.mkdirSync(channelDirectory)
				request(channel.banner).pipe(fs.createWriteStream("#{assetsDirectory}/#{channel.name}#{path.extname(channel.banner)}"))

			[0...config[channel.name]].forEach (i)->
				songOption =
					url: playlistUrl
					qs:
						type: 'n'
						channel: channel.id
						from: 'mainsite'
					i: i
					channel: channel

				fetchSong(songOption)

fetchSong = (option)->
	request option, (error, response, body)->
		song = JSON.parse(body).song[0]
		if song
			request albumUrl + song.album, (albumError, albumResponse, albumBody)->
				if albumBody
					$ = cheerio.load(albumBody)
					text = $('#link-report .all.hidden').text().trim()
					
					if not text
						console.log('retry summary')
						text = $('#link-report').text().trim()
						if not text
							console.log('retry refresh', option.channel.name)
							return fetchSong(option)
						else
							console.log('success summary')
					else
						console.log('success hidden')

					request(song.picture).pipe(fs.createWriteStream("#{assetsDirectory}/#{option.channel.name}/#{song.title}#{path.extname(song.picture)}"))
					request(song.url).pipe(fs.createWriteStream("#{assetsDirectory}/#{option.channel.name}/#{song.title}#{path.extname(song.url).replace('mp4', 'm4a')}"))
					
					fs.writeFile "#{assetsDirectory}/#{option.channel.name}/#{song.title}.txt", text, (error)->
						console.error(error) if error

					console.log(option.channel.name, option.i, song.title)
				else
					console.log('empty albumBody')
					fetchSong(option)
		else
			fetchSong(option)
