'use strict'

GalleryApp = angular.module('GalleryApp', ['ngMaterial', 'ngRoute', 'ngAnimate', 'GalleryController', 'GalleryService'])

GalleryApp.config ['$routeProvider', ($routeProvider)->
	$routeProvider.when('/'
		templateUrl: '/partial/line.html'
		controller: 'LineController'
	).when('/list'
		templateUrl: '/partial/list.html'
	).otherwise(
		redirectTo: '/'
	)
]
