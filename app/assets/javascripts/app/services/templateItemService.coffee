'use strict'

app.service 'TemplateItemService', ['$http', 'API_URL', ($http, API_URL) ->
  @save = (template_id, item) ->
    return $http.post API_URL + 'templates/' + template_id + '/template_items', item

  @update = (item_id, description) ->
    params =
      name: description

    return $http.put(API_URL + 'template_items/' + item_id, params)

  @fetch = (template_id) ->
    $http.get(API_URL + 'templates/' + template_id + '/template_items').success (data, status, headers, config) ->
      return data
    .error (data, status, headers, config) ->
      console.log('Error in templateItemService, method fetch()')
      return 'Error'

  @get = (id) ->
    return $http.get(API_URL + 'template_items/' + id)

  @delete = (item_id) ->
    return $http.delete(API_URL + 'template_items/' + item_id)
  return
]
