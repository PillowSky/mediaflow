'use strict'

GalleryController = angular.module('GalleryController', [])

GalleryController.controller 'HeaderController', ['$scope', ($scope)->
	randomInt = (min, max)->
		Math.floor(min + Math.random() * (max - min))
	$scope.imageIndex = randomInt(0, 20)
]

GalleryController.controller 'LineController', ['$scope', '$location', 'Asset', 'Memo', ($scope, $location, Asset, Memo)->
	asset = Memo('asset')

	if asset
		$scope.asset = asset
	else
		asset = Asset.get()
		asset.$promise.then ->
			$scope.asset = asset
			Memo('asset', asset)

	$scope.gotoList = ->
		Memo('category', this.category)
		$location.url('/list')
]

GalleryController.controller 'ListController', ['$scope', 'Asset', 'Summary', 'Memo', '$sce', ($scope, Asset, Summary, Memo, $sce)->
	$scope.memo = Memo()
	asset = Memo('asset')

	if asset
		$scope.asset = asset
		$scope.memo.category = Object.keys(asset)[0] if not $scope.memo.category
		$scope.memo.item = Object.keys(asset[$scope.memo.category])[0]
	else
		asset = Asset.get()
		asset.$promise.then ->
			$scope.asset = asset
			$scope.memo.category = Object.keys(asset)[0] if not $scope.memo.category
			$scope.memo.item = Object.keys(asset[$scope.memo.category])[0]
			Memo('asset', asset)

	$scope.categoryClicked = ->
		Memo('category', this.category)
		$scope.memo.item = Object.keys(asset[$scope.memo.category])[0]

	$scope.categoryIsSelected = ->
		this.category == Memo('category')

	$scope.itemClicked = ->
		Memo('item', this.item)

	$scope.itemIsSelected = ->
		this.item == Memo('item')

	$scope.$watch 'memo.item', (newValue, oldValue)->
		if newValue
			$scope.summary = Summary.text
				category: Memo('category')
				filename: asset[Memo('category')][Memo('item')].text
]