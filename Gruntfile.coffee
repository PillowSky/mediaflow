'use strict'

request = require('request')

module.exports = (grunt) ->
	require('time-grunt')(grunt)
	require('load-grunt-tasks')(grunt)
	reloadPort = 35729

	grunt.initConfig
		pkg:
			grunt.file.readJSON('package.json')
		develop:
			server:
				file: 'bin/www'
		less:
			dist:
				files: 'public/css/style.css': 'public/css/style.less'
		coffee:
			dist:
				files:
					'public/js/app.js': 'public/js/app.coffee'
					'public/js/controller.js': 'public/js/controller.coffee'
		watch:
			options:
				spawn: false
				livereload: reloadPort
			server:
				files: ['bin/www', 'app.js', 'routes/*.coffee']
				tasks: ['develop', 'delayed-livereload']
			views:
				files: ['views/*.jade']
				options:
					livereload: reloadPort
			css:
				files: ['public/css/*.less']
				tasks: ['less']
				options:
					livereload: reloadPort
			js:
				files: ['public/js/*.coffee']
				tasks: ['coffee']
				options:
					livereload: reloadPort

	grunt.config.requires 'watch.server.files'
	files = grunt.config('watch.server.files')
	files = grunt.file.expand(files)

	grunt.registerTask 'delayed-livereload', 'Live reload after the node server has restarted.', ->
		done = @async()
		setTimeout ->
			request.get "http://localhost:#{reloadPort}/changed?files=#{files.join(',')}", (err, res) ->
				reloaded = !err and res.statusCode == 200
				if reloaded
					grunt.log.ok 'Delayed live reload successful.'
				else
					grunt.log.error 'Unable to make a delayed live reload.'
				done reloaded
		, 500

	grunt.registerTask 'default', ['less', 'coffee', 'develop', 'watch']
