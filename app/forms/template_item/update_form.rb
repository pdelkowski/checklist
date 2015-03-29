class TemplateItem::UpdateForm < Form
  attribute :name

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 100 }
end