module Api::V1::ItemsController::Documentation
  extend ActiveSupport::Concern
  
  included do
    resource_description do
      formats ['json']
      api_version 'v1'
    end
    
    api :GET, '/v1/checklists/:checklist_id/items', 'Get list of all items by specified checklist'
    error 404, 'resource_not_found - when checklist specied by :checklist_id is not found'
    def index
    end
  
    api :POST, '/v1/checklists/:checklist_id/items', 'Creates new item in specified checklist'
    error 404, 'resource_not_found - when checklist specied by :checklist_id is not found'
    param :name, String, desc: 'Name of checklist item', required: true,
      meta: { length: '>= 2 AND <= 100 characters' }
    def create
    end
  
    api :GET, '/v1/items/:id', 'Get checklist item'
    error 404, 'resource_not_found - when checklist item specified by :id is not found'
    def show
    end
  
    api :PUT, '/v1/items/:id', 'Update checklist item'
    error 404, 'resource_not_found - when checklist item specified by :id is not found'
    param :name, String, desc: 'Name of checklist item', required: true,
      meta: { length: '>= 2 AND <= 100 characters' }
    def update
    end
  
    api :POST, '/v1/items/:id/complete', 'Mark as completed specified checlist item'
    error 404, 'resource_not_found - when checklist item specified by :id is not found'
    def complete
    end
  
    api :POST, '/v1/items/:id/uncomplete', 'Mark as uncomplete specified checklist item'
    error 404, 'resource_not_found - when checklist item specified by :id is not found'
    def uncomplete
    end
  
    api :DELTE, '/v1/items/:id', 'Delete specified checklist item'
    error 404, 'resource_not_found - when checklist item specified by :id is not found'
    def destroy
    end
  end
end
