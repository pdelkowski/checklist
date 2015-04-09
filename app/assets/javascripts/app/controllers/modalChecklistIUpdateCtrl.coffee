'use strict'

app.controller 'modalChecklistUpdateCtrl', ['$scope', '$rootScope', '$state', '$stateParams', '$modalInstance', 'ChecklistService', 'checklist', ($scope, $rootScope, $state, $stateParams, $modalInstance, ChecklistService, checklist) ->
  $scope.checklist =
    name: checklist.name
    id: checklist.id

  # Update checklist
  $scope.checklistUpdate = (checklist_id, name) ->
    $promise = ChecklistService.update(checklist_id, name)
    $promise.success (data, status) ->
      $state.transitionTo($state.current, $stateParams, {reload: true })
      $rootScope.addAlert('success', 'Checklist successfully updated')
    $promise.error (data) ->
      $rootScope.addAlert('danger', data.message)

    $modalInstance.close($scope.item)

  # Exit modal
  $scope.cancel = () ->
    $modalInstance.dismiss('Cancel')
]
