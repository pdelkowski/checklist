class Item < ActiveRecord::Base
  belongs_to :checklist

  validates :description,
      presence: true,
      length: { minimum: 2, maximum: 100 }
end
