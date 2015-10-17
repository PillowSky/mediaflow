'use strict'

GalleryService = angular.module('GalleryService', ['ngResource'])

GalleryService.factory 'Asset', ['$resource', ($resource)->
	$resource '/asset/'
]
