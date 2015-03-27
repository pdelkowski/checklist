var checklistControllers = angular.module('checklistControllers', []);

// Checklists controller
checklistControllers.controller('ChecklistsController', ['$scope', '$http',
    function ($scope, $http) {
        // Get list of all checklists
        $http.get('/api/v1/checklists.json').success(function(data) {
            $scope.checklists = data;
        });

        $scope.newChecklist = '';

        $scope.addChecklist = function() {
            var newChecklist = {
                name: $scope.newChecklist.trim()
            };

            if(!newChecklist.name) {
                return;
            }

            $http.post('/api/v1/checklists', newChecklist)
                .success(function(data) {
                    $scope.newChecklist = '';
                    $scope.checklists.unshift(data);
                });
        };
    }]);

// Checklist items controller
checklistControllers.controller('ChecklistItemsController', ['$scope', '$routeParams', '$http',
    function ($scope, $routeParams, $http) {
        // Get list of all items
        $http.get('/api/v1/checklists/'+ $routeParams.id +'/items.json').success(function(data) {
            $scope.items = data;
        });

        $scope.newItem = '';

        $scope.addItem = function() {
            var newItem = {
                description: $scope.newItem.trim(),
            };

            if(!newItem.description) {
                return;
            }

            $http.post('/api/v1/checklists/'+ $routeParams.id +'/items', newItem)
                .success(function(data){
                    $scope.newItem = '';
                    $scope.items.unshift(data);
                });
        };

        $scope.itemCompleted = function(clickEvent, itemId) {
            // When item has been checked
            if(clickEvent.toElement.checked) {
                $http.post('/api/v1/items/'+itemId+'/complete');
            } else { // or unchecked
                $http.post('/api/v1/items/'+itemId+'/uncomplete');
            }
        };
    }]);