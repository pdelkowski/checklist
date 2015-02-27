var checklistControllers = angular.module('checklistControllers', []);

checklistControllers.controller('ChecklistItemsController', ['$scope', '$http',
    function ($scope, $http) {
        // Get list of all items
        $http.get('/items.json').success(function(data) {
            $scope.items = data;
        });

        $scope.itemCompleted = function(clickEvent, itemId) {
            // When item has been checked
            if(clickEvent.toElement.checked) {
                $http.post('/items/'+itemId+'/complete');
            } else { // or unchecked
                $http.post('/items/'+itemId+'/uncomplete');
            }
        };
    }]);