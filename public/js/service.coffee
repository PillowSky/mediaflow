'use strict'

GalleryService = angular.module('GalleryService', ['ngResource'])

GalleryService.factory 'Asset', ['$resource', ($resource)->
	$resource '/asset/'
]

GalleryService.factory 'Summary', ['$resource', ($resource)->
	$resource '/assets/', {},
		text:
			url: '/assets/:folder/:filename'
			method: 'GET'
			responseType: 'text'
			transformResponse: (data, headersGetter, status)->
				return {text: data}
]
