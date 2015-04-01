'use strict'
app.constant 'APP_MEDIAQUERY', {
  'desktopXL': 1200,
  'desktop': 992,
  'tablet': 768,
  'mobile': 480
}

app.constant 'API_URL', 'http://192.168.59.103:4000/api/v1/'

app.constant 'JS_REQUIRES', {
  scripts: {
  ## Javascript Plugins

  ## jQuery Plugins

  ## Controllers
    'checklistCtrl': 'assets/controllers/checklistCtrl.js'
  }
  ## angularJS Modules
  # modules: [{
  #   name: 'ngTable',
  #   files: ['vendor/ng-table.min.js', 'ng-table.min.css']
  # }]

}
