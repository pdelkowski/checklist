'use strict'

app.service 'ChecklistService', ['$http', 'API_URL', ($http, API_URL) ->
  @create = (checklist) ->
    return $http.post(API_URL + '/checklists', checklist)

  @update = (checklist_id, name) ->
    params =
      name: name

    return $http.put(API_URL + 'checklists/' + checklist_id, params)

  @search = (query) ->
    return $http.get(API_URL+query)

  @fetch = () ->
    $http.get(API_URL + 'checklists').success (data, status, headers, config) ->
      return data
    .error (data, status, headers, config) ->
      console.log('Error in checklistService, method fetch()')
      return 'Error'

  @get = (id) ->
    return $http.get(API_URL + 'checklists/' + id)

  @delete = (checklist_id) ->
    console.log checklist_id
    return $http.delete(API_URL + 'checklists/' + checklist_id)
  return
]
