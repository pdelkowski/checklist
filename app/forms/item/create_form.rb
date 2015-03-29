class Item::CreateForm < Form
  attribute :checklist_id
  attribute :description

  validates :description,
            presence: true,
            length: { minimum: 2, maximum: 100 }
end