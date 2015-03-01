var checklistApp = angular.module('checklistApp', [
    'ngRoute',
    'checklistControllers'
]);

checklistApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider
        .when('/', {
            templateUrl: 'app/partials/checklists.html',
            controller: 'ChecklistsController'
        })
        .when('/checklists/:id', {
            templateUrl: 'app/partials/checklist-items.html',
            controller: 'ChecklistItemsController'
        });
  }]);