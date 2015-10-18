GalleryController = angular.module('GalleryController', [])

GalleryController.controller 'LineController', ['$scope', 'Asset', ($scope, Asset)->
	asset = Asset.get()
	asset.$promise.then ->
		$scope.asset = asset
]

GalleryController.controller 'ListController', ['$scope', 'Asset', 'Summary', ($scope, Asset, Summary)->
	asset = Asset.get()
	asset.$promise.then ->
		$scope.asset = asset

	para =
		folder: '动画'
		filename: 'Blender.txt'
	result = Summary.text(para)
	result.$promise.then ->
		$scope.summary = result.text

]

GalleryController.controller 'FlowController', ['$scope', 'Asset', ($scope, Asset)->
	asset = Asset.get()
	asset.$promise.then ->
		$scope.asset = asset
]
