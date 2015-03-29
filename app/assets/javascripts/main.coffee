'use strict'
window.app = angular.module "checklistApp", ["appDeps"]

app.run ['$rootScope', '$state', '$stateParams', 'editableOptions', ($rootScope, $state, $stateParams, editableOptions) ->
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams

  $rootScope.editableOptions.theme = 'bs3'

  $rootScope.app =
    name: 'checklistApp',
    author: 'Azbestowy Firewall',
    version: '1.0'
    year: new Date().getFullYear()
    isMobile: () ->
      if /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) then check = true else check = false
      return check

]
