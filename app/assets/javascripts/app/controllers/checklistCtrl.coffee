'use strict'

app.controller 'checklistListCtrl', ['$scope', 'ChecklistService', 'checklists', 'templates', ($scope, ChecklistService, checklists, templates) ->
  $scope.checklists = checklists.data
  $scope.templates = templates.data
  console.log $scope.templates

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

  # Update checklist
  $scope.checklistUpdate = (checklist_id, name) ->
    $promise = ChecklistService.update(checklist_id, name)
    $promise.success (data, status) ->
      console.log 'Checklist successfully updated'
  #
  # Delete item
  $scope.checklistDelete = (checklist_id, index) ->
    $promise = ChecklistService.delete(checklist_id)
    $promise.success (data, status) ->
      $scope.checklists.splice(index, 1)
      console.log 'Checklist successfully removed'
]

app.controller 'checklistDetailCtrl', ['$scope', '$stateParams', 'ItemService', 'checklist', 'checklist_items', ($scope, $stateParams, ItemService, checklist, checklist_items) ->
  $scope.checklist = checklist.data
  $scope.checklist_items = checklist_items.data

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
      $scope.checklist_items.unshift(data)
      $scope.formItemDescription = null

  # Update item
  $scope.itemUpdate = (item_id, description) ->
    $promise = ItemService.update(item_id, description)
    $promise.success (data, status) ->
      console.log 'Item successfully updated'

  # Delete item
  $scope.itemDelete = (item_id, index) ->
    $promise = ItemService.delete(item_id)
    $promise.success (data, status) ->
      $scope.checklist_items.splice(index, 1)
      console.log 'Item successfully removed'

  # Complete/Uncomplete item
  $scope.itemComplete = (e, item_id) ->
    if(e.toElement.checked)
      $promise = ItemService.complete(item_id)
      $promise.success (data, status) ->
        console.log 'Successfully completed item'
    else
      $promise = ItemService.uncomplete(item_id)
      $promise.success (data, status) ->
        console.log 'Successfully uncompleted item'
]
