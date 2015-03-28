class TemplateItemForm < Form
  attribute :template_id, Integer
  attribute :name, String
  
  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 100 }
end
