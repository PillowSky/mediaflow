'use strict'

GalleryService = angular.module('GalleryService', ['ngResource'])

GalleryService.factory 'Asset', ['$resource', ($resource)->
	$resource '/asset/'
]

GalleryService.factory 'Summary', ['$resource', ($resource)->
	$resource '/assets/', {},
		text:
			url: '/assets/:category/:filename'
			method: 'GET'
			responseType: 'text'
			transformResponse: (data, headersGetter, status)->
				return {text: data}
]

GalleryService.factory 'Memo', ->
	memo = {}
	return (key, value)->
		if value
			memo[key] = value
		else if key
			return memo[key]
		else
			return memo
