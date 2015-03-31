'use strict'

app.service 'ChecklistService', ['$http', 'API_URL', 'ItemService', ($http, API_URL, ItemService) ->
  @create = (checklist) ->
    return $http.post(API_URL + '/checklists', checklist)

  @update = (checklist_id, name) ->
    params =
      name: name

    return $http.put(API_URL + 'checklists/' + checklist_id, params)

  @count_items = (checklist_id) ->
    ItemService.fetch(checklist_id).then (value) ->
      items = value

    items = data.data
    count = 0
    completed = 0

    for item in items
      count = count+1
      if item.completed_at
        completed = completed+1

      result =
        count: count,
        completed: completed,
        uncompleted: count-completed
    console.log result

  @count_completed = (checklist_id) ->

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
