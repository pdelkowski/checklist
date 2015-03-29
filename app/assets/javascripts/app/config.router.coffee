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
    controller: 'checklistDetailCtrl',
    resolve:
      checklist: ($stateParams, ChecklistService) ->
        return ChecklistService.get($stateParams.checklist_id)
      checklist_items: ($stateParams, ItemService) ->
        return ItemService.fetch($stateParams.checklist_id)

  .state 'templates',
    title: 'Template',
    url: "/templates",
    templateUrl: "app/partials/template.list.html",
    controller: 'templateListCtrl',
    resolve:
      templates: (TemplateService) ->
        return TemplateService.fetch()
  .state 'templates_show',
    title: 'Template',
    url: "/templates/:template_id",
    templateUrl: "app/partials/template.detail.html",
    controller: 'templateDetailCtrl',
    resolve:
      template: ($stateParams, TemplateService) ->
        return TemplateService.get($stateParams.template_id)
      template_items: ($stateParams, TemplateItemService) ->
        return TemplateItemService.fetch($stateParams.template_id)

]
