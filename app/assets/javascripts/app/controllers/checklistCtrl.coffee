'use strict'

app.controller 'checklistListCtrl', ['$scope', '$stateParams', '$filter', 'ChecklistService', 'ItemService', 'checklists', 'templates', ($scope, $stateParams, $filter, ChecklistService, ItemService, checklists, templates) ->
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
      console.log 'Checklist created'
]

app.controller 'checklistDetailCtrl', ['$scope', '$stateParams', '$location', '$state', 'ChecklistService', 'ItemService', 'checklist', 'checklist_items', ($scope, $stateParams, $location, $state, ChecklistService, ItemService, checklist, checklist_items) ->
  $scope.checklist = checklist.data
  $scope.checklist_items = checklist_items.data

  # Update checklist
  $scope.checklistUpdate = (checklist_id, name) ->
    $promise = ChecklistService.update(checklist_id, name)
    $promise.success (data, status) ->
      $state.transitionTo($state.current, $stateParams, {reload: true })
      console.log 'Checklist successfully updated'

  # Delete checklist
  $scope.checklistDelete = (checklist_id) ->
    $promise = ChecklistService.delete(checklist_id)
    $promise.success (data, status) ->
      console.log 'Checklist successfully removed'
      console.log $state.current
      $state.transitionTo("checklists", $stateParams, {reload: true })

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

  # Update item
  $scope.itemUpdate = (item_id, description) ->
    $promise = ItemService.update(item_id, description)
    $promise.success (data, status) ->
      console.log 'Item successfully updated'

  # Delete item
  $scope.itemDelete = (item_id, index) ->
    $promise = ItemService.delete(item_id)
    $promise.success (data, status) ->
      $state.transitionTo($state.current, $stateParams, {reload: true })
      console.log 'Item successfully removed'

  # Complete/Uncomplete item
  $scope.itemComplete = (e, item_id) ->
    if(e.target.checked)
      $promise = ItemService.complete(item_id)
      $promise.success (data, status) ->
        console.log 'Item successfully completed'
    else
      $promise = ItemService.uncomplete(item_id)
      $promise.success (data, status) ->
        console.log 'Successfully uncompleted item'
    $state.transitionTo($state.current, $stateParams, {reload: true })
]
