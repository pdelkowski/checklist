'use strict'

app.controller 'mainCtrl', ['$scope', '$rootScope', '$stateParams', '$timeout', ($scope, $rootScope, $stateParams, $timeout) ->
  # Message alerts
  $scope.alerts = []


  $rootScope.addAlert = (type, message) ->
    $scope.alerts.push
      type: type,
      msg: message
    # $scope.alerts = [
    #   type: type,
    #   msg: message
    # ]

    $timeout (->
      $rootScope.closeAlert(this)
    ), 3000


  $rootScope.closeAlert = (index) ->
    $scope.alerts.splice(index, 1)
]
