class Item < ActiveRecord::Base
  belongs_to :checklist

  def completed?
    !completed_at.nil?
  end
end
