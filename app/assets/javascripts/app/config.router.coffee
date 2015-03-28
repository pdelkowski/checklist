'use strict'

app.config ['$stateProvider', '$urlRouterProvider', '$controllerProvider', '$compileProvider', '$filterProvider', '$provide', '$ocLazyLoadProvider', 'JS_REQUIRES', ($stateProvider, $urlRouterProvider, $controllerProvider, $compileProvider, $filterProvider, $provide, $ocLazyLoadProvider, jsRequires) ->
  app.controller = $controllerProvider.register
  app.directive = $compileProvider.directive
  app.filter = $filterProvider.register
  app.factory = $provide.factory
  app.service = $provide.service
  app.constant = $provide.constant
  app.value = $provide.value


  # $ocLazyLoadProvider.config
  #   debug: true,
  #   events: true,
  #   modules: jsRequires.modules


  $urlRouterProvider.otherwise "/checklists"

  $stateProvider.state 'checklists',
    title: 'Checklists',
    url: "/checklists",
    templateUrl: "app/partials/checklist.list.html",
    controller: 'checklistListCtrl',
    resolve:
      checklists: (ChecklistService) ->
        return ChecklistService.fetch()
  .state 'checklists_show',
    title: 'Checklist',
    url: "/checklists/:checklist_id",
    templateUrl: "app/partials/checklist.detail.html",
    controller: 'checklistShowCtrl',
    resolve:
      checklist: ($stateParams, ChecklistService) ->
        return ChecklistService.fetch($stateParams.checklist_id)
      checklist_items: ($stateParams, ItemService) ->
        return ItemService.fetch($stateParams.checklist_id)

  .state '/template',
    title: 'Templates',
    url: "/templates",
    templateUrl: "partials/templates.html",
    controller: 'templatesCtrl',
    resolve:
      users: ['TemplatesService', (TemplatesService) ->
        return TemplatesService.fetch()
      ]
]
