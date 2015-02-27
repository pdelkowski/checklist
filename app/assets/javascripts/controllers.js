var checklistControllers = angular.module('checklistControllers', []);

checklistControllers.controller('ChecklistItemsController', ['$scope', '$http',
    function ($scope, $http) {
        $http.get('/items.json').success(function(data) {
            $scope.items = data;
        });

        $scope.itemCompleted = function(clickEvent) {
            if(clickEvent.toElement.checked) {

            }
        };
    }]);