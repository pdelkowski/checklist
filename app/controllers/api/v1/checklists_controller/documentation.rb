module Api::V1::ChecklistsController::Documentation
  extend ActiveSupport::Concern
  
  included do
    resource_description do
      formats ['json']
      api_version 'v1'
    end
    
    api :GET, '/v1/checklists', 'Gett list of all checklists'
    def index      
    end
    
    api :POST, '/v1/checklists', 'Create new checklist'
    param :name, String, desc: 'Name of the checklist', required: true,
      meta: { length: 'minimum: 2, maximum: 100' }
    def create
    end
    
    api :GET, '/v1/checklists/:id', 'Get checklist specified by :id'
    error 404, 'resource_not_found - specified checklist not found'
    error 422, 'validation_failed - request with invalid data. Response errors object contains details'
    def show
    end
    
    api :PUT, '/v1/checklists/:id', 'Update checklists specified by :id'
    param :name, String, desc: 'Name of the checklist',
      meta: { length: 'minimum: 2, maximum: 100' }
    error 404, 'resource_not_found - specified checklist not found'
    error 422, 'validation_failed - request with invalid data. Response errors object contains details'
    def update
    end
    
    api :DELETE, '/v1/checklists/:id', 'Remove checklist specified by :id'
    param :id, Integer, 'ID of the checklist'
    error 404, 'resource_not_found - specified checklist not found'
    def destroy
    end
  end
end