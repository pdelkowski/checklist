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
    url: "/checklists",
    views:
      'checklistList':
        title: 'Checklists',
        templateUrl: "app/partials/checklists.html",
        controller: 'checklistListCtrl',
        resolve:
          checklists: (ChecklistService) ->
            return ChecklistService.fetch()
          templates: (TemplateService) ->
            return TemplateService.fetch()
      'checklistDetail':
        templateUrl: "app/partials/homepage.html",
  .state 'checklists_show',
    url: "/checklists/:checklist_id",
    views:
      'checklistList':
        title: 'Checklists',
        templateUrl: "app/partials/checklists.html",
        controller: 'checklistListCtrl',
        resolve:
          checklists: (ChecklistService) ->
            return ChecklistService.fetch()
          templates: (TemplateService) ->
            return TemplateService.fetch()
      'checklistDetail':
        title: 'Checklist',
        templateUrl: "app/partials/items.html",
        controller: 'checklistDetailCtrl',
        resolve:
          checklist: ($stateParams, ChecklistService) ->
            return ChecklistService.get($stateParams.checklist_id)
          checklist_items: ($stateParams, ItemService) ->
            return ItemService.fetch($stateParams.checklist_id)

  .state 'templates',
    url: "/templates",
    views:
      'checklistList':
        title: 'Template',
        templateUrl: "app/partials/templates.html",
        controller: 'templateListCtrl',
        resolve:
          templates: (TemplateService) ->
            return TemplateService.fetch()
      'checklistDetail':
        templateUrl: "app/partials/homepage.html",
  .state 'templates_show',
    url: "/templates/:template_id",
    views:
      'checklistList':
        title: 'Template',
        templateUrl: "app/partials/templates.html",
        controller: 'templateListCtrl',
        resolve:
          templates: (TemplateService) ->
            return TemplateService.fetch()
      'checklistDetail':
        title: 'Template',
        templateUrl: "app/partials/template_items.html",
        controller: 'templateDetailCtrl',
        resolve:
          template: ($stateParams, TemplateService) ->
            return TemplateService.get($stateParams.template_id)
          template_items: ($stateParams, TemplateItemService) ->
            return TemplateItemService.fetch($stateParams.template_id)

]
