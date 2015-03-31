// Generated by CoffeeScript 1.9.1
(function() {
  'use strict';
  app.service('TemplateService', [
    '$http', 'API_URL', function($http, API_URL) {
      this.create = function(template) {
        return $http.post(API_URL + 'templates', template);
      };
      this.update = function(template_id, name) {
        var params;
        params = {
          name: name
        };
        return $http.put(API_URL + 'templates/' + template_id, params);
      };
      this.fetch = function() {
        return $http.get(API_URL + 'templates').success(function(data, status, headers, config) {
          return data;
        }).error(function(data, status, headers, config) {
          console.log('Error in templateService, method fetch()');
          return 'Error';
        });
      };
      this.get = function(id) {
        return $http.get(API_URL + 'templates/' + id);
      };
      this["delete"] = function(template_id) {
        console.log(template_id);
        return $http["delete"](API_URL + 'templates/' + template_id);
      };
    }
  ]);

}).call(this);