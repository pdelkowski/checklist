class TemplateItem::CreateForm < Form
  attribute :template_id
  attribute :name

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 100 }
end