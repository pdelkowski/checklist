Apipie.configure do |config|
  config.app_name                = "Checklists"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/api/docs"
  config.default_version         = "v1"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
