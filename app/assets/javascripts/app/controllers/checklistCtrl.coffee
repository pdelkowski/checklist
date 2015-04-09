'use strict'

app.controller 'checklistListCtrl', ['$scope', '$rootScope', '$stateParams', '$filter', 'ChecklistService', 'ItemService', 'checklists', 'templates', ($scope, $rootScope, $stateParams, $filter, ChecklistService, ItemService, checklists, templates) ->
  $scope.checklists = checklists.data
  $scope.templates = templates.data

  # Set the active checklist
  for key, checklist of $scope.checklists
    if parseInt(checklist.id) == parseInt($stateParams.checklist_id)
      $scope.checklists[key]['active'] = true
    else
      $scope.checklists[key]['active'] = false

  # console.log $scope.checklists
  $scope.formChecklistName = ''

  # Add checklist
  $scope.formChecklistSubmit = () ->
    formParams =
      name: $scope.formChecklistName.trim(),

    if( $scope.formChecklistTemplate )
      formParams['from_template'] = $scope.formChecklistTemplate.id

    if(!$scope.formChecklistName)
      return

    $promise = ChecklistService.create(formParams)
    $promise.success (data, status) ->
      $scope.checklists.unshift(data)
      $scope.formChecklistName = null
      $rootScope.addAlert('success', 'Checklist created')
    $promise.error (data) ->
      $rootScope.addAlert('danger', data.message)
]

app.controller 'checklistDetailCtrl', ['$scope', '$rootScope', '$stateParams', '$location', '$state', '$modal', 'ChecklistService', 'ItemService', 'checklist', 'checklist_items', ($scope, $rootScope, $stateParams, $location, $state, $modal, ChecklistService, ItemService, checklist, checklist_items) ->
  $scope.checklist = checklist.data
  $scope.checklist_items = checklist_items.data

  # Update checklist
  $scope.checklistUpdate = (checklist_id, name) ->
    $promise = ChecklistService.update(checklist_id, name)
    $promise.success (data, status) ->
      $state.transitionTo($state.current, $stateParams, {reload: true })
      $rootScope.addAlert('success', 'Checklist successfully updated')
    $promise.error (data) ->
      $rootScope.addAlert('danger', data.message)

  # Modal window for checklist update
  $scope.modalChecklistEdit = () ->
    modalInstance = $modal.open(
      templateUrl: 'checklistEditModal.html'
      controller: 'modalChecklistUpdateCtrl'
      resolve: checklist: ->
        $scope.checklist
    )

  # Delete checklist
  $scope.checklistDelete = (checklist_id) ->
    $promise = ChecklistService.delete(checklist_id)
    $promise.success (data, status) ->
      $rootScope.addAlert('success', 'Checklist successfully removed')
      $state.transitionTo("checklists", $stateParams, {reload: true })
    $promise.error (data) ->
      $rootScope.addAlert('danger', data.message)

  $scope.formItemDescription = ''

  # Add item
  $scope.formItemSubmit = () ->
    formParams =
      description: $scope.formItemDescription.trim(),
      checklist_id: $scope.checklist.id

    if(!$scope.formItemDescription)
      return

    $promise = ItemService.save($stateParams.checklist_id, formParams)
    $promise.success (data, status) ->
      $state.transitionTo($state.current, $stateParams, {reload: true })
      $rootScope.addAlert('success', 'Item successfully added')
    $promise.error (data) ->
      $rootScope.addAlert('danger', data.message)

  # Modal window for update
  $scope.modalItemEdit = (index) ->
    console.log 'in modal'
    modalInstance = $modal.open(
      templateUrl: 'myModalContent.html'
      controller: 'modalInstanceCtrl'
      resolve: item: ->
        $scope.checklist_items[index]
    )

  # Delete item
  $scope.itemDelete = (item_id, index) ->
    $promise = ItemService.delete(item_id)
    $promise.success (data, status) ->
      $state.transitionTo($state.current, $stateParams, {reload: true })
      $rootScope.addAlert('success', 'Item successfully removed')
    $promise.error (data) ->
      $rootScope.addAlert('danger', data.message)

  # Complete/Uncomplete item
  $scope.itemComplete = (e, item_id) ->
    if(e.target.checked)
      $promise = ItemService.complete(item_id)
      $promise.success (data, status) ->
        $rootScope.addAlert('success', 'Item successfully completed')
      $promise.error (data) ->
        $rootScope.addAlert('danger', data.message)
    else
      $promise = ItemService.uncomplete(item_id)
      $promise.success (data, status) ->
        $rootScope.addAlert('success', 'Successfully uncompleted item')
      $promise.error (data) ->
        $rootScope.addAlert('danger', data.message)

    $state.transitionTo($state.current, $stateParams, {reload: true })
]
