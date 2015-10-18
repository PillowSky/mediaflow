'use strict'

GalleryApp = angular.module('GalleryApp', ['ngMaterial', 'ngRoute', 'ngAnimate', 'GalleryController', 'GalleryService'])

GalleryApp.config ['$routeProvider', ($routeProvider)->
	$routeProvider.when('/'
		templateUrl: '/partial/line.html'
		controller: 'LineController'
	).when('/line'
		templateUrl: '/partial/line.html'
		controller: 'LineController'
	).when('/list'
		templateUrl: '/partial/list.html'
		controller: 'ListController'
	).when('/list/:category'
		templateUrl: '/partial/list.html'
		controller: 'ListController'
	).when('/flow'
		templateUrl: '/partial/flow.html',
		controller: 'FlowController'
	).otherwise(
		redirectTo: '/'
	)
]
