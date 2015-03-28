'use strict'

app.config ['$stateProvider', '$urlRouterProvider', '$controllerProvider', '$compileProvider', '$filterProvider', '$provide', '$ocLazyLoadProvider', 'JS_REQUIRES', ($stateProvider, $urlRouterProvider, $controllerProvider, $compileProvider, $filterProvider, $provide, $ocLazyLoadProvider, jsRequires) ->
  app.controller = $controllerProvider.register;
  app.directive = $compileProvider.directive;
  app.filter = $filterProvider.register;
  app.factory = $provide.factory;
  app.service = $provide.service;
  app.constant = $provide.constant;
  app.value = $provide.value;

  app.constant 'API_URL', 'http://localhost:3000/api/v1/'

  $ocLazyLoadProvider.config
    debug: true,
    events: true,
    modules: jsRequires.modules


  $urlRouterProvider.otherwise "/checklists"

  $stateProvider.state 'checklists',
    title: 'Checklists',
    url: "/checklists",
    templateUrl: "app/partials/checklists.html",
    controller: 'checklistCtrl',
    resolve:
      checklists: ['ChecklistService', (ChecklistService) ->
        throw new Error("my error message in resolve");
        console log 'in resolve'
        return ChecklistService.fetch()
      ]
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
