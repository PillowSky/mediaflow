'use strict'

GalleryFilter = angular.module('GalleryFilter', [])

GalleryFilter.filter 'ConcatAudioSrc', ['$sce', ($sce)->
	(prefix, category, filename)->
		if category and filename
			return $sce.trustAsResourceUrl("#{prefix}/#{category}/#{filename}")
]