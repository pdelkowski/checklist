class Checklist::CreateForm < Form
  attribute :name
  attribute :from_template, Integer

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 100 }
            
  validate  :template_has_to_exists
  
  private
  
    def template_has_to_exists
      return if from_template.nil?
      Template.find(from_template)
    rescue ActiveRecord::RecordNotFound
      errors.add(:from_template, 'resource_not_found')
    end
end