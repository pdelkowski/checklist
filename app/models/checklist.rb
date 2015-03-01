class Checklist < ActiveRecord::Base
  has_many :items

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 100 }
end
