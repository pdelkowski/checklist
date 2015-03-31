'use strict'

app.service 'ItemService', ['$http', 'API_URL', ($http, API_URL) ->
  @save = (checklist_id, item) ->
    return $http.post API_URL + '/checklists/' + checklist_id + '/items', item

  @update = (item_id, description) ->
    params =
      description: description

    return $http.put(API_URL + 'items/' + item_id, params)

  @complete = (item_id) ->
    return $http.post(API_URL + 'items/' + item_id + '/complete')

  @uncomplete = (item_id) ->
    return $http.post(API_URL + 'items/' + item_id + '/uncomplete')

  @fetch = (checklist_id) ->
    $http.get(API_URL + '/checklists/' + checklist_id + '/items').success (data, status, headers, config) ->
      return data
    .error (data, status, headers, config) ->
      console.log('Error in itemService, method fetch()')
      return 'Error'

  @get = (id) ->
    return $http.get(API_URL + 'items/' + id)

  @delete = (item_id) ->
    return $http.delete(API_URL + 'items/' + item_id)
  return
]
