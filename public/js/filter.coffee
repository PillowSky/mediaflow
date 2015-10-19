'use strict'

GalleryFilter = angular.module('GalleryFilter', [])

GalleryFilter.filter 'ConcatAudioSrc', ->
	(prefix, category, filename)->
		if category and filename
			return "#{prefix}/#{category}/#{filename}"
