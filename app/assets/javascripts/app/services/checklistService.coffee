'use strict'

app.service 'ChecklistService', ['$http', 'API_URL', ($http, API_URL) ->
  @save = (event) ->
    return $http.post '/checklists', event

  @search = (query) ->
    return $http.get(API_URL+query)

  @fetch = () ->
    $http.get(API_URL + 'checklists').success (data, status, headers, config) ->
      return data
    .error (data, status, headers, config) ->
      console.log('Error in checklistService, method fetch()')
      return 'Error'

  @get = (id) ->
    return $http.get(API_URL + 'chechlists/' + id)
  return
]
