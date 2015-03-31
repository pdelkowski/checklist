app.directive 'ngConfirmClick', [ ->
      priority: -1
      restrict: 'A'
      link: (scope, element, attrs) ->
        element.bind 'click', (e) ->
          message = attrs.ngConfirmClick
          if message and !confirm(message)
            e.stopImmediatePropagation()
            e.preventDefault()
          return
        return
]
