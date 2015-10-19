'use strict'

GalleryApp = angular.module('GalleryApp', ['ngMaterial', 'ngRoute', 'ngAnimate', 'GalleryController', 'GalleryService', 'GalleryFilter'])

GalleryApp.config ['$routeProvider', ($routeProvider)->
	$routeProvider.when('/'
		templateUrl: '/partial/line.html'
		controller: 'LineController'
	).when('/list'
		templateUrl: '/partial/list.html'
		controller: 'ListController'
	).otherwise(
		redirectTo: '/'
	)
]
