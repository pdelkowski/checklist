module Api::V1::TemplatesController::Documentation
  extend ActiveSupport::Concern
  
  included do
    resource_description do
      formats ['json']
      api_version 'v1'
    end
    
    api :GET, '/v1/templates', 'Gets all checklists templates'
    def index
    end
    
    api :POST, '/v1/templates', 'Creates new checklist template'
    param :name, String, desc: 'Name of template checklist', required: true,
      meta: { length: '>=2 AND <= 100 characters' }
    error 422, 'validation_failed - when send data are invalid. See errors object in reponse'
    def create
    end
    
    api :GET, '/v1/templates/:id', 'Gets specified checklist template'
    error 404, 'resource_not_found - when template is not found'
    def show
    end
    
    api :PUT, '/v1/templates/:id', 'Updates specified checklist template'
    param :name, String, desc: 'Name of template checklist',
      meta: { length: '>=2 AND <= 100 characters' }
    error 404, 'resource_not_found - when template is not found'
    error 422, 'validation_failed - when send data are invalid. See errors object in reponse'
    def update
    end
    
    api :DELETE, '/v1/templates/:id', 'Removes specified checklist template'
    error 404, 'resource_not_found - when template is not found'
    def destroy
    end
  end
end
