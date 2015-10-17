GalleryController = angular.module('GalleryController', [])

GalleryController.controller 'SceneController', ['$scope', 'Asset', ($scope, Asset)->
	asset = Asset.get()
	asset.$promise.then ->
		$scope.asset = asset
]
