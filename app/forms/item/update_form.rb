class Item::UpdateForm < Form
  attribute :description

  validates :description,
            presence: true,
            length: { minimum: 2, maximum: 100 }
end