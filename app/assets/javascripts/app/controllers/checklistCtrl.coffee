'use strict'

app.controller 'checklistListCtrl', ['$scope', 'checklists', ($scope, checklists) ->
  $scope.checklists = checklists.data
]

app.controller 'checklistShowCtrl', ['$scope', '$stateParams', 'ItemService', 'checklist', 'checklist_items', ($scope, $stateParams, ItemService, checklist, checklist_items) ->
  $scope.checklist = checklist.data
  $scope.checklist_items = checklist_items.data

  $scope.newItemModel = ''

  $scope.createItem = () ->
    console.log $scope.newItemModel
    newItemModel =
      description: $scope.newItemModel.trim(),
      checklist_id: $scope.checklist[0].id

    if(!newItemModel.description)
      return

    ItemService.save($stateParams.checklist_id, newItemModel)

      # $http.post('/api/v1/checklists/'+ $routeParams.id +'/items', newItem)
      #   .success(function(data){
      #     $scope.newItem = '';
      #         $scope.items.unshift(data);
      #   });

]
