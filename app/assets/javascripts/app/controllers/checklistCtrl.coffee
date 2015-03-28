'use strict'

app.controller 'checklistListCtrl', ['$scope', 'checklists', ($scope, checklists) ->
  console.log checklists
  $scope.checklists = checklists.data
]
