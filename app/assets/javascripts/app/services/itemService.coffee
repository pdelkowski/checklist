'use strict'

app.service 'ItemService', ['$http', 'API_URL', ($http, API_URL) ->
  @save = (checklist_id, item) ->
    return $http.post API_URL + '/checklists/' + checklist_id + '/items', item

  @search = (query) ->
    return $http.get(API_URL+query)

  @fetch = (checklist_id) ->
    $http.get(API_URL + '/checklists/' + checklist_id + '/items').success (data, status, headers, config) ->
      return data
    .error (data, status, headers, config) ->
      console.log('Error in itemService, method fetch()')
      return 'Error'

  @get = (id) ->
    return $http.get(API_URL + 'items/' + id)
  return
]
