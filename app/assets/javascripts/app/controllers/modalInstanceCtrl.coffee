'use strict'

app.controller 'modalInstanceCtrl', ['$scope', '$rootScope', '$state', '$stateParams', '$modalInstance', 'ItemService', 'item', ($scope, $rootScope, $state, $stateParams, $modalInstance, ItemService, item) ->
  $scope.item =
    id: item.id
    description: item.description

  $scope.itemUpdate = (item_id, description) ->
    $promise = ItemService.update(item_id, description)
    $promise.success (data, status) ->
      $rootScope.addAlert('success', 'Item successfully updated')
      $state.transitionTo($state.current, $stateParams, {reload: true })
    $promise.error (data) ->
      $rootScope.addAlert('danger', data.message)

    $modalInstance.close($scope.item)

  $scope.cancel = () ->
    $modalInstance.dismiss('Cancel')
]
