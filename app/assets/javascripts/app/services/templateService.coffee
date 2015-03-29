'use strict'

app.service 'TemplateService', ['$http', 'API_URL', ($http, API_URL) ->
  @create = (template) ->
    return $http.post(API_URL + 'templates', template)

  @update = (template_id, name) ->
    params =
      name: name

    return $http.put(API_URL + 'templates/' + template_id, params)

  @fetch = () ->
    $http.get(API_URL + 'templates').success (data, status, headers, config) ->
      return data
    .error (data, status, headers, config) ->
      console.log('Error in templateService, method fetch()')
      return 'Error'

  @get = (id) ->
    return $http.get(API_URL + 'templates/' + id)

  @delete = (template_id) ->
    console.log template_id
    return $http.delete(API_URL + 'templates/' + template_id)
  return
]
