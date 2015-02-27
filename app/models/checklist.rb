class Checklist < ActiveRecord::Base
  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 100 }
end
