'use strict'

app.controller 'templateListCtrl', ['$scope', 'TemplateService', 'templates', ($scope, TemplateService, templates) ->
  $scope.templates = templates.data

  $scope.formTemplateName = ''

  # Add template
  $scope.formTemplateSubmit = () ->
    formParams =
      name: $scope.formTemplateName.trim(),

    if(!$scope.formTemplateName)
      return

    $promise = TemplateService.create(formParams)
    $promise.success (data, status) ->
      $scope.templates.unshift(data)
      $scope.formTemplateName = null
      console.log 'Template created'

  # Update template
  $scope.templateUpdate = (template_id, name) ->
    $promise = TemplateService.update(template_id, name)
    $promise.success (data, status) ->
      console.log 'template successfully updated'
  #
  # Delete template
  $scope.templateDelete = (template_id, index) ->
    $promise = TemplateService.delete(template_id)
    $promise.success (data, status) ->
      $scope.templates.splice(index, 1)
      console.log 'Template successfully removed'
]

app.controller 'templateDetailCtrl', ['$scope', '$stateParams', 'TemplateItemService', 'template', 'template_items', ($scope, $stateParams, TemplateItemService, template, template_items) ->
  $scope.template = template.data
  $scope.template_items = template_items.data

  $scope.formTemplateItemDescription = ''

  # Add item
  $scope.formTemplateItemSubmit = () ->
    formParams =
      name: $scope.formTemplateItemDescription.trim(),
      template_id: $scope.template.id

    if(!$scope.formTemplateItemDescription)
      return

    $promise = TemplateItemService.save($stateParams.template_id, formParams)
    $promise.success (data, status) ->
      $scope.template_items.unshift(data)
      $scope.formTemplateItemDescription = null

  # Update item
  $scope.templateItemUpdate = (templateItem_id, description) ->
    $promise = TemplateItemService.update(templateItem_id, description)
    $promise.success (data, status) ->
      console.log 'Template item successfully updated'

  # Delete item
  $scope.templateItemDelete = (templateItem_id, index) ->
    $promise = templateItemService.delete(templateItem_id)
    $promise.success (data, status) ->
      $scope.template_items.splice(index, 1)
      console.log 'Template item successfully removed'
]
