module Api::V1::TemplateItemsController::Documentation
  extend ActiveSupport::Concern
  
  included do
    resource_description do
      formats ['json']
      api_version 'v1'
    end
    
    api :GET, '/v1/templates/:id/items', 'Gets all items by specified template'
    error 404, 'resource_not_found - when checklist template is not found'
    def index
    end
    
    api :POST, '/v1/templates/:id/items', 'Creates new item for specified template'
    param :name, String, desc: 'Item name', required: true, 
      meta: { length: '>=2 AND <=100 characters' }
    error 404, 'resource_not_found - when checklist template is not found'
    error 422, 'validation_failed - send data are invalid. See errors object in response'
    def create
    end
    
    api :GET, '/v1/template_items/:id', 'Get specified template item'
    error 404, 'resource_not_found - item not found'
    def show
    end
    
    api :PUT, '/v1/template_items/:id', 'Updates specified template item'
    param :name, String, desc: 'Item name',
      meta: { length: '>=2 AND <=100 characters' }
    error 404, 'resource_not_found - item not found'
    error 422, 'validation_failed - send data are invalid. See errors object in response'
    def update
    end
    
    api :DELETE, '/v1/template_items/:id', 'Destroys specified template item'
    error 404, 'resource_not_found - item not found'
    def destroy
    end
  end
end
