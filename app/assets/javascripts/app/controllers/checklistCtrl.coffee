'use strict'

app.controller 'checklistCtrl', ($scope, checklists) ->
  console log 'in checklistCtrl'
  console log checklists
  $scope.checklists = checklists.data.results
