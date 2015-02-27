var checklistApp = angular.module('checklistApp', [
    'ngRoute',
    'checklistControllers'
]);

checklistApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
        when('/', {
            templateUrl: 'app/partials/checklist-items.html',
            controller: 'ChecklistItemsController'
        });
  }]);