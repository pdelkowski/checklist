'use strict'

app.controller 'checklistListCtrl', ['$scope', 'checklists', ($scope, checklists) ->
  $scope.checklists = checklists.data
]

app.controller 'checklistShowCtrl', ['$scope', '$stateParams', 'ItemService', 'checklist', 'checklist_items', ($scope, $stateParams, ItemService, checklist, checklist_items) ->
  $scope.checklist = checklist.data
  $scope.checklist_items = checklist_items.data

  $scope.formItemDescription = ''

  $scope.formItemSubmit = () ->
    formParams =
      description: $scope.formItemDescription.trim(),
      checklist_id: $scope.checklist[0].id

    if(!$scope.formItemDescription)
      return

    $promise = ItemService.save($stateParams.checklist_id, formParams)
    $promise.success (data, status) ->
      $scope.checklist_items.unshift(data)
      $scope.formItemDescription = null

]
